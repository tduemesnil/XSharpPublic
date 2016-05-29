﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
using Microsoft.VisualStudio.Shell.Design.Serialization;
using System;
using System.CodeDom;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security.Permissions;
using System.Text;
using System.Threading.Tasks;

namespace XSharp.CodeDom
{
    [ComVisibleAttribute(true)]
    [PermissionSetAttribute(SecurityAction.LinkDemand, Name = "FullTrust")]
    [PermissionSetAttribute(SecurityAction.InheritanceDemand, Name = "FullTrust")]
    public partial class XSharpCodeDomProvider : CodeDomProvider
    {
        protected XSharpCodeGenerator xsGenerator;
        public int TabSize { get; set; }

        public XSharpCodeDomProvider()
        {
            this.xsGenerator = new XSharpCodeGenerator();
            this.TabSize = 1;
        }

        [Obsolete]
        public override ICodeCompiler CreateCompiler()
        {
            return this.xsGenerator;
        }

        [Obsolete]
        public override ICodeGenerator CreateGenerator()
        {
            return this.xsGenerator;
        }

        [Obsolete]
        public override ICodeParser CreateParser()
        {
            var parser = new XSharpCodeParser();
            parser.TabSize = this.TabSize;
            return parser;
        }

        // Called by the WinForm designer at save time
        public override void GenerateCodeFromCompileUnit(CodeCompileUnit compileUnit, TextWriter writer, CodeGeneratorOptions options)
        {
            // Does that CodeCompileUnit comes from a "Merged" unit ?
            if (compileUnit.UserData.Contains("XSharp:HasDesigner"))
            {
                // Retrieve the Form Class
                CodeNamespace designerNamespace;
                CodeTypeDeclaration designerClass = XSharpCodeDomHelper.FindDesignerClass(compileUnit, out designerNamespace);
                // and retrieve the filename of the prg file
                String prgFileName = (string)compileUnit.UserData["XSharp:FileName"];
                // Build the Designer FileName
                String designerPrgFile = XSharpCodeDomHelper.BuildDesignerFileName(prgFileName);
                // Retrieve Both CodeCompileUnit
                CodeCompileUnit formCCU = (CodeCompileUnit)compileUnit.UserData["XSharp:Form"];
                CodeCompileUnit designCCU = (CodeCompileUnit)compileUnit.UserData["XSharp:Designer"];
                //
                CodeNamespace formNamespace;
                CodeTypeDeclaration formClass = XSharpCodeDomHelper.FindFirstClass(formCCU, out formNamespace);
                CodeNamespace designNamespace;
                CodeTypeDeclaration designClass = XSharpCodeDomHelper.FindFirstClass(designCCU, out designNamespace);
                // Now, remove the members
                formClass.Members.Clear();
                designClass.Members.Clear();
                // Now, rebuild the members
                foreach (CodeTypeMember ctm in designerClass.Members)
                {
                    // Was it a member that we have found in the original merged CodeCompileUnits ?
                    if (ctm.UserData.Contains("XSharp:FromDesigner"))
                    {
                        if ( (bool)ctm.UserData.Contains("XSharp:FromDesigner"))
                        {
                            // Comes from the Designer.prg file
                            // so go back to Designer.prg
                            designClass.Members.Add(ctm);
                        }
                        else
                        {
                            // Comes from the original Form file
                            formClass.Members.Add(ctm);
                        }
                    }
                    else
                    {
                        // This must be a member generated by the Designer !
                        // So we will move Methods to the Form and all others to the Designer
                        if ( ctm is CodeMemberMethod )
                        {
                            formClass.Members.Add(ctm);
                        }
                        else
                        {
                            designClass.Members.Add(ctm);
                        }
                    }
                }
                // now, we must save both CodeCompileUnit
                // The received TextWriter is pointing to the Form
                // so we must create our own TextWriter for the Designer
                // First, let's make in Memory
                String generatedSource;
                MemoryStream inMemory = new MemoryStream();
                StreamWriter designerStream = new StreamWriter( inMemory, System.Text.Encoding.Default);
                // 
                base.GenerateCodeFromCompileUnit(designCCU, designerStream, options);
                // and force Flush
                designerStream.Flush();
                designerStream.Close();
                // Reset and read to String
                inMemory.Position = 0;
                StreamReader reader = new StreamReader(inMemory, System.Text.Encoding.Default);
                generatedSource = reader.ReadToEnd();
                reader.Close();
                // and now write the "real" file
                designerStream = new StreamWriter(designerPrgFile, false, System.Text.Encoding.Default);
                designerStream.Write(generatedSource);
                designerStream.Flush();
                designerStream.Close();
                // The problem here, is that we "may" have some new members, like EvenHandlers, and we need to update their position (line/col)
                XSharpCodeParser parser = new XSharpCodeParser();
                CodeCompileUnit resultDesigner = parser.Parse(generatedSource);
                CodeNamespace resultNamespace;
                CodeTypeDeclaration resultClass = XSharpCodeDomHelper.FindDesignerClass(resultDesigner, out resultNamespace);
                // just to be sure...
                if ( resultClass != null )
                {
                    // Now push all elements from resultClass to designClass
                    designClass.Members.Clear();
                    foreach (CodeTypeMember ctm in resultClass.Members)
                    {
                        designClass.Members.Add(ctm);
                    }
                }
                // Ok,we MUST do the same thing for the Form file



            }
            else
                base.GenerateCodeFromCompileUnit(compileUnit, writer, options);
            //
#if WRITE2LOGFILE
            string path = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            path = Path.Combine(path, "XSharpDumpCodeCompileUnit_generate.log");
            XSharpCodeDomHelper.DumpCodeCompileUnit(compileUnit, path, true);
#endif
        }

        // Called by the WinForm designer at load time
        public override CodeCompileUnit Parse(TextReader codeStream)
        {
            CodeCompileUnit compileUnit = null;

            // If the TextReader is a DocDataTextReader, we should be running from VisualStudio, called by the designer
            // So, we will guess the FileName to check if we have a .Designer.Prg file at the same place.
            // If so, we will have to handle both .prg to produce two CodeCompileUnit, then we will merge the result into one, with markers in it
            // so we can split again when the Designer is willing to save. ( See GenerateCodeFromCompileUnit )
            if (codeStream is DocDataTextReader)
            {
                // Anyway, we have that source, just parse it.
                compileUnit = base.Parse(codeStream);
                // Now, we should check if we have a partial Class inside, if so, that's a Candidate for .Designer.prg
                CodeNamespace nameSpace;
                CodeTypeDeclaration className;
                if (XSharpCodeDomHelper.HasPartialClass(compileUnit, out nameSpace, out className))
                {
                    // Ok, so get the Filename, to get the .Designer.prg
                    DocDataTextReader ddtr = codeStream as DocDataTextReader;
                    DocData dd = ((IServiceProvider)ddtr).GetService(typeof(DocData)) as DocData;
                    String prgFileName = dd.Name;
                    // Build the Designer FileName
                    String designerPrgFile = XSharpCodeDomHelper.BuildDesignerFileName(prgFileName);
                    if (File.Exists(designerPrgFile))
                    {
                        // Ok, we have a candidate !!!
                        DocData docdata = new DocData((IServiceProvider)ddtr, designerPrgFile);
                        DocDataTextReader reader = new DocDataTextReader(docdata);
                        // so parse
                        CodeCompileUnit designerCompileUnit = base.Parse(reader);
                        // Now we have Two CodeCompileUnit, we must merge them
                        compileUnit = XSharpCodeDomHelper.MergeCodeCompileUnit(compileUnit, designerCompileUnit);
                        compileUnit.UserData["XSharp:HasDesigner"] = true;
                        compileUnit.UserData["XSharp:FileName"] = prgFileName;
                        // Save CCU for GenerateCode operation, it will be faster and easier than to recreate it
                        compileUnit.UserData["XSharp:Form"] = compileUnit;
                        compileUnit.UserData["XSharp.Designer"] = designerCompileUnit;
                    }
                }
            }
            else
            {
                compileUnit = base.Parse(codeStream);
            }
            //
#if WRITE2LOGFILE
            string path = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            path = Path.Combine(path, "XSharpDumpCodeCompileUnit_parse.log");
            XSharpCodeDomHelper.DumpCodeCompileUnit(compileUnit, path, true);
#endif
            return compileUnit;
        }

    }
}
