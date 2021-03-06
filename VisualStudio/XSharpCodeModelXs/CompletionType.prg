//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
using EnvDTE
using System
using System.Collections.Generic
using System.Diagnostics
using System.Linq
using System.Text
using System.Threading.Tasks
using XSharpModel
begin namespace XSharpModel
	[DebuggerDisplay("{FullName,nq}")];
	class CompletionType
		// Fields
		private _codeElt as CodeElement
		private _file as XFile
		private _stype as System.Type
		private _xtype as XType
		
		// Methods
		constructor()
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := null
		
		constructor(elt as CodeElement)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := null 
			self:_codeElt := elt
		
		constructor(sType as System.Type)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := null
			self:_stype := sType
		
		constructor(element as XElement)
			super()
			local oMember as XTypeMember
			local parent as XTypeMember
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := null
			self:_file := element:file
			if ((element is XType))
				//
				self:_xtype := (XType)element 
			else
				//
				if ((element is XTypeMember))

					oMember := (XTypeMember)(element)
					self:CheckType(oMember:TypeName, oMember:file, oMember:Parent:NameSpace)
				else

					if ((element:Parent is XType))
	
						self:_xtype := (XType)(element:Parent)
					else
	
						parent := (XTypeMember)(element:Parent)
						if (parent != null)
		
							self:CheckType(parent:TypeName, parent:file, parent:Parent:NameSpace)
						endif
					endif
				endif
			endif
		
		constructor(xType as XType)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_xtype := xType
			self:_file  := xType:File
		
		constructor(element as XTypeMember)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := element:file
			if element:Kind:HasReturnType()
				//
				self:CheckType(element:TypeName, element:file, element:Parent:NameSpace)
			else
				//
				self:_xtype := (XType) element:Parent
			endif
		
		constructor(xvar as XVariable, defaultNS as string)
			super()
			local parent as XTypeMember
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := null
			parent := (XTypeMember)(xvar:Parent)
			self:_file := xvar:file
			if (parent != null)
				//
				if (! String.IsNullOrEmpty(parent:Parent:NameSpace))

					defaultNS := ((XType)parent:Parent):NameSpace
				endif
				self:CheckType(xvar:TypeName, parent:file, defaultNS)
			endif
		
		constructor(typeName as string, xFile as XFile, usings as IList<string>)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
			self:_file := xFile
			self:CheckType(typeName, xFile, usings)
		
		constructor(typeName as string, xFile as XFile, defaultNS as string)
			super()
			//
			self:_stype := null
			self:_xtype := null
			self:_codeElt := null
            		SELF:_file := null
			self:CheckType(typeName, xFile, defaultNS)
		
		private method CheckProjectType(typeName as string, xprj as XProject, usings as IList<string>) as void
			local xType as XType
			local fqn as string
			//
			xType := xprj:Lookup(typeName, true)
			if xType == null
				xType := xprj:LookupFullName(typeName, true)
				if xType == null .AND. usings != null

					foreach usingStatement as string in usings:Expanded()
						fqn := fqn + "." + typeName
						xType := xprj:LookupFullName(fqn, true)
						if (xType != null)
							exit
						endif
					next
				endif
			endif
			if xType != null
				self:_xtype := xType
			endif
		
		private method CheckStrangerProjectType(typeName as string, xprj as XProject, usings as IList<string>) as void
			local codeElt as CodeElement
            		LOCAL fqn AS string
			codeElt := xprj:LookupForStranger(typeName, true)
			if codeElt == null
				foreach usingStatement as string in usings:Expanded()
					fqn :=  usingStatement +  "." + typeName
					codeElt := xprj:LookupForStranger(fqn, true)
					if codeElt != null
						exit
					endif
				next
			endif
			if codeElt != null
				self:_codeElt := codeElt
			endif
		
		private method CheckSystemType(typeName as string, usings as IList<string>) as void
			local sType as System.Type
			sType := self:SimpleTypeToSystemType(typeName)
			if sType == null .AND. self:_file != null
				typeName := typeName:GetSystemTypeName()
				sType := self:_file:Project:FindSystemType(typeName, usings)
			endif
			if sType != null
				self:_stype := sType
			endif
		
		private method CheckType(typeName as string, xFile as XFile, usings as IList<string>) as void
			//
			self:_file := xFile
			if self:_file?:Project != null
				//
				self:CheckProjectType(typeName, xFile:Project, usings)
				if ! self:IsInitialized

					self:CheckSystemType(typeName, usings)
					if ! self:IsInitialized
	
						foreach prj as XProject in xFile:Project:ReferencedProjects
							self:CheckProjectType(typeName, prj, usings)
							if self:IsInitialized
								exit
							endif
						next
					endif
				endif
			endif
		
		private method CheckType(typeName as string, xFile as XFile, defaultNS as string) as void
			local usings as List<string>
			usings := List<string>{xFile:Usings}
			if ! String.IsNullOrEmpty(defaultNS)
				usings:Add(defaultNS)
			endif
			self:CheckType(typeName, xFile, usings)
		
		internal method SimpleTypeToSystemType(kw as string) as System.Type
			//
			if (kw != null)
				//
				switch kw:ToLowerInvariant()
					case "string"
						return typeof(string)
					
					case "dword"
					case "uint32"
						return typeof(dword)
					case "int64"
						return typeof(int64)
					
					case "int16"
					case "shortint"
					case "short"
						return typeof(short)
					case "longint"
					case "long"
					case "int"
					case "int32"
						return typeof(long)
					case "void"
					
					case "byte"
						return typeof(byte)
					
					case "word"
					case "uint16"
					case "char"
						return typeof(char)
					
					case "real4"
						return typeof(real4)
					
					
					case "real8"
						return typeof(real8)
					
					case "uint64"
						return typeof(uint64)
					
					case "logic"
						return typeof(logic)
					
					case "sbyte"
						return typeof(SByte)
					
				end switch
			endif
			return null
		
		// Properties
		property CodeElement as CodeElement get self:_codeElt
		property File as XFile get self:_file
		
		property FullName as string
			get
				if (self:_xtype != null)
					return self:_xtype:FullName
				endif
				if (self:_stype != null)
					return self:_stype:GetXSharpTypeName()
				endif
				if (self:_codeElt != null)
					return self:_codeElt:FullName
				endif
				return null
			end get
		end property
		
		property IsInitialized as logic get self:_stype != null .OR. self:_xtype != null .OR. self:_codeElt != null
		
		property ParentType as CompletionType
			get
				if (self:_stype != null)
					return CompletionType{self:_stype:BaseType}
				endif
				if (self:_xtype != null)

					if (self:_xtype:Parent != null)
	
						return CompletionType{self:_xtype:Parent}
					endif
					if (self:_xtype:ParentName  !=null)
	
						var defaultNS := ""
						if (! String.IsNullOrEmpty(self:_xtype:NameSpace))
		
							defaultNS := self:_xtype:NameSpace
						endif
						return CompletionType{self:_xtype:ParentName, self:_xtype:File, defaultNS}
					endif
				endif
				return CompletionType{"System.Object", null, ""}
			end get
		end property
		
		property SType as System.Type get self:_stype
		property XType as XType get self:_xtype
		
	end class
	
end namespace 

