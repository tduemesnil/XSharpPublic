﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
using System.Collections.Generic;
using System.Linq;
using Microsoft.VisualStudio.Package;
using System.Collections;
using Microsoft.VisualStudio.TextManager.Interop;
using XSharpModel;

namespace XSharp.LanguageService
{

    public sealed class XSharpTypeAndMemberDropDownBars : TypeAndMemberDropdownBars
    {
        int lastLine = -1;
        XElement _lastSelected;
        XElement  _lastType;
        ArrayList _members = null;
        XFile _file = null;
        uint _lastHashCode = 0;
        bool lastIncludeFields = false;

        public XSharpTypeAndMemberDropDownBars(
            XSharpLanguageService lang,
            IVsTextView view)
            : base(lang)
        {
        }
        public override int OnItemChosen(int combo, int entry)
        {
            bool handled = false;
            if (combo == 1 && entry < _members?.Count && entry >= 0)
            {
                var member = _members[entry] as XDropDownMember;
                if (member.Element.File != _file)
                { 
                    member.Element.OpenEditor();
                    handled = true;
                }
            }
            if (! handled)
                return base.OnItemChosen(combo, entry);
            return 0;
        }
        public override bool OnSynchronizeDropdowns(
            Microsoft.VisualStudio.Package.LanguageService languageService,
            IVsTextView textView,
            int line,
            int col,
            ArrayList dropDownTypes,
            ArrayList dropDownMembers,
            ref int selectedType,
            ref int selectedMember)
        {
            //
            var package = XSharp.Project.XSharpProjectPackage.Instance;
            var optionsPage = package.GetIntellisenseOptionsPage();
            var sortItems = optionsPage.SortNavigationBars;
            var includeFields = optionsPage.IncludeFieldsInNavigationBars;
            if (optionsPage.DisableEditorDropdowns)
            {
                dropDownTypes.Clear();
                dropDownMembers.Clear();
                selectedType = selectedMember = -1;
                return true;
            }
            // when the line did not change, we do nothing for performance reasons
            // this speeds up typing  for buffers with lots of entities
            if (line == lastLine)
            {
                // same line, no changes
                return false;
            }
            lastLine = line;

            Source src = languageService.GetSource(textView);
            string srcFile = src.GetFilePath();
            //
            XFile file = XSolution.FindFullPath(srcFile);
            if (file == null || file.TypeList == null)
            {
                return false;
            }
            XElement selectedElement = file.FindMemberAtRow(line);
            if (selectedElement == _lastSelected)
            {
                // Same element, no changes
                return false;
            }
            // check if we are on the same type. When not then we need to reload the members.
            // Note that the first item in the members combo can also be a type (Classname)
            XElement parentType = null;
            if (selectedElement is XTypeMember)
            {
                parentType  = selectedElement.Parent;
            }
            else if (selectedElement is XType)
            {
                parentType = selectedElement as XType;
            }
            bool newType = true;
            if (parentType != null && _lastType != null && parentType.FullName == _lastType.FullName)
            {
                newType = false;
            }
            // when we are on the same type and there are no new methods then we can 
            // select the element in the members combo and we do not have to rebuild the members 
            // list. We must set the selectedType and selectedMember
            if (! newType && file.ContentHashCode == _lastHashCode && lastIncludeFields == includeFields )
            {
                // no need to rebuild the list. Just focus to another element
                // locate item in members collection
                selectedMember = -1;
                selectedType = -1;
                for (int i = 0; i < dropDownMembers.Count; i++)
                {
                    var member = (XDropDownMember) dropDownMembers[i];
                    if (member.Element.Prototype == selectedElement.Prototype)
                    {
                        selectedMember = i;
                        break;
                    }
                }
                // find the parentType in the types combo
                if (selectedMember != -1 && parentType != null) // should never be null
                {
                    for (int i = 0; i < dropDownTypes.Count; i++)
                    {
                        var member = (XDropDownMember)dropDownTypes[i];
                        var type = member.Element as XType;
                        if (type.FullName == parentType.FullName)
                        {
                            selectedType = i;
                            break;
                        }
                    }
                }
                // normally we should always find it. But if it fails then we simply build the list below.
                if (selectedMember != -1 && selectedType != -1)
                {
                    // remember for later. No need to remember the type because it has not changed
                    _lastSelected = selectedElement;
                    return true;
                }
            }
            dropDownTypes.Clear();
            dropDownMembers.Clear();
            int nSelType = -1;
            int nSelMbr = -1;
            //int distanceM = int.MaxValue;
            DROPDOWNFONTATTR ft;
            //
            //
            if (file.TypeList.Count > 0)
            {
                nSelType = 0;
            }

            List<XType> xList = file.TypeList.Values.ToList<XType>();
            if (sortItems)
            {
                xList.Sort(delegate (XType elt1, XType elt2)
                {
                    return elt1.Name.CompareTo(elt2.Name);
                });
            }
            XType typeGlobal = null;
            int nSelect  = 0;

            XElement  currentMember = null;
            XType currentType = null;

            if (selectedElement is XTypeMember)
            {
                currentMember = selectedElement as XTypeMember;
                currentType = ((XTypeMember) currentMember).Parent;
            }
            else if (selectedElement is XType)
            {
                currentType = selectedElement as XType;
                currentMember = null;
            }
            nSelect = 0;
            XDropDownMember elt;
            // C# shows all items PLAIN
            // but when the selection is not really on an item, but for example on a comment
            // between methods, or on the comments between the namespace and the first class
            // then the next method/class is selected and displayed in GRAY
            // C# also includes members (for partial classes) that are defined in other source files
            // these are colored GRAY
            foreach (XType eltType in xList)
            {
                if (eltType.Kind == Kind.Namespace)
                    continue;
                //
                if (XType.IsGlobalType(eltType))
                {
                    typeGlobal = eltType;
                }
                TextSpan sp = this.TextRangeToTextSpan(eltType.Range);
                ft = DROPDOWNFONTATTR.FONTATTR_PLAIN;
                string name = eltType.Name ;
                if (string.IsNullOrEmpty(name))
                {
                    name = "?";
                }
                elt = new XDropDownMember(name, sp, eltType.Glyph, ft);
                elt.Element = eltType;
                nSelect = dropDownTypes.Add(elt);
                if (eltType?.FullName == currentType?.FullName)
                {
                    nSelType = nSelect;
                }
            }

            if (currentType == null)
            { 
                currentType = typeGlobal;
            }
            bool hasPartial = false;
            if (currentType != null)    // should not happen since all files have a global type
            {
                nSelMbr = 0;
                IList<XTypeMember> members;
                if (currentType != typeGlobal && currentType.IsPartial)
                {
                    // retrieve members from other files ?
                    var fullType = file.Project.LookupFullName(currentType.FullName, true);
                    hasPartial = true;
                    members = fullType.Members;
                }
                else
                {
                    members = currentType.Members;
                }
                if (sortItems)
                {
                    members = members.OrderBy(x => x.Name).ToList();
                }
                // Add member for class declaration. This also makes sure that there at least one
                // element in the members list, which is convenient.
                TextSpan spM = this.TextRangeToTextSpan(currentType.Range);
                ft = DROPDOWNFONTATTR.FONTATTR_PLAIN;
                if (currentType != typeGlobal)
                {
                    if (currentType.Kind != Kind.Delegate)
                    {
                        elt = new XDropDownMember("(" + currentType.Name + ")", spM, currentType.Glyph, ft);
                        elt.Element = currentType;
                        dropDownMembers.Add(elt);
                    }
                }
                else
                {
                    elt = new XDropDownMember(currentType.Name, spM, currentType.Glyph, ft);
                    elt.Element = currentType;
                    dropDownMembers.Add(elt);
                }
                foreach (XElement  member in members)
                {
                    if (includeFields || (member.Kind != Kind.Field  && member.Kind != Kind.VODefine))
                    {
                        spM = this.TextRangeToTextSpan(member.Range);

                        if (hasPartial)
                        { 
                            ft = member.File == file ? DROPDOWNFONTATTR.FONTATTR_PLAIN : DROPDOWNFONTATTR.FONTATTR_GRAY;
                        }

                        string prototype = member.Prototype;
                        elt = new XDropDownMember(prototype, spM, member.Glyph, ft);
                        nSelect = dropDownMembers.Add(elt);
                        elt.Element = member;
                        if (member == currentMember)
                        {
                            nSelMbr = nSelect;
                        }
                    }
                }
            }
            // save the info so we can optimize the next call.
            _members = dropDownMembers;
            _file = file;
            _lastSelected = selectedElement;
            _lastType = currentType;
            _lastHashCode = file.ContentHashCode;
            selectedType    = nSelType;
            selectedMember  = nSelMbr;
            lastIncludeFields = includeFields;
            return true;
        }

        private TextSpan TextRangeToTextSpan(TextRange tr)
        {
            // It seems that TextSpan is Zero-based
            // where our TextRange is One-Based.
            // --> Make the move
            TextSpan ts = new TextSpan();
            ts.iStartLine = tr.StartLine - 1;
            ts.iStartIndex = tr.StartColumn - 1;
            ts.iEndLine = tr.EndLine - 1;
            ts.iEndIndex = tr.EndColumn - 1;
            // validate values
            if (ts.iStartLine < 0)
                ts.iStartLine = 0;
            if (ts.iStartIndex < 0)
                ts.iStartIndex = 0;
            if (ts.iEndLine < ts.iStartLine)
                ts.iEndLine = ts.iStartLine;
            if (ts.iEndIndex < ts.iStartLine && ts.iStartLine == ts.iEndLine)
                ts.iEndIndex = ts.iStartIndex;
            return ts;
        }

    }
    internal class XDropDownMember : DropDownMember
    {
            internal XDropDownMember(string label, TextSpan span, int glyph, DROPDOWNFONTATTR fontAttribute) :
            base(label, span, glyph, fontAttribute)
        {

        }
        internal XElement Element { get; set; }
    }
}

