﻿// Functions.prg
// Created by    : robert
// Creation Date : 8/8/2017 11:57:43 AM
// Created for   : 
// WorkStation   : ZEUS

using System.Collections.Generic
using XSharpModel
using System.Windows.Forms

STATIC CLASS XFuncs

STATIC METHOD FindItemsOfType(oProject as XProject, xType as XFileType, aProjects := NULL  as List<XProject>) as List<XFile>
	VAR aResult := List<XFile>{}
	if (aProjects == null)
		aProjects := List<XProject>{}
	endif
	FOREACH oOther as XFile in oProject:OtherFiles
		if oOther:XFileType == xType
			aResult:Add(oOther)	
		endif
	NEXT
	aProjects:Add(oProject)
	FOREACH oRef as XProject in oProject:ReferencedProjects
		if !aProjects:Contains(oRef)
			aProjects:Add(oRef)
			VAR aTmp := XFuncs.FindItemsOfType(oRef, xType, aProjects)
			aResult:AddRange(aTmp)
		endif		
	NEXT
	RETURN aResult

   STATIC METHOD QuestionBox(cMessage AS STRING , cCaption AS STRING) AS LOGIC
	   RETURN MessageBox.Show(cMessage , cCaption , MessageBoxButtons.YesNo , MessageBoxIcon.Question) == DialogResult.Yes
   
STATIC METHOD ErrorBox(cMessage AS STRING , cCaption AS STRING) AS VOID
      MessageBox.Show(cMessage , cCaption , MessageBoxButtons.OK , MessageBoxIcon.Error)
   RETURN
   STATIC METHOD ErrorBox(cMessage AS STRING) AS VOID
      MessageBox.Show(cMessage , "XSharp"  , MessageBoxButtons.OK , MessageBoxIcon.Error)
   RETURN
   STATIC METHOD WarningBox(cMessage AS STRING , cCaption AS STRING) AS VOID
      MessageBox.Show(cMessage , cCaption , MessageBoxButtons.OK , MessageBoxIcon.Warning)
   RETURN
   STATIC METHOD WarningBox(cMessage AS STRING) AS VOID
      MessageBox.Show(cMessage , "XSharp"  , MessageBoxButtons.OK , MessageBoxIcon.Warning)
   RETURN

   STATIC METHOD GetModuleFilenameFromBinary(cFileName AS STRING) AS STRING
      LOCAL cModuleName := "", cModuleFilename := "" AS STRING
      IF SplitBinaryFilename(cFileName , REF cModuleName , REF cModuleFilename)
         RETURN cModuleFilename
      END IF
   RETURN NULL

   STATIC METHOD SplitBinaryFilename(cFileName AS STRING , cModuleName REF STRING , cModuleFilename REF STRING) AS LOGIC
      LOCAL lOk AS LOGIC
      LOCAL nAt AS INT
      TRY
         nAt := cFileName:LastIndexOf('.')
         cFileName := cFileName:Substring(0 , nAt)
         nAt := cFileName:LastIndexOf('.')
         cFileName := cFileName:Substring(0 , nAt)
         cModuleFilename := cFileName
         nAt := cFileName:LastIndexOf('\\')
         cFileName := cFileName:Substring(nAt + 1)
         cModuleName := cFileName
         lOk := TRUE
	  CATCH
		 lOk := FALSE
      END TRY
   RETURN lOk
	STATIC METHOD WriteHeader(oGenerator as XIDE.CodeGenerator, cTool as string) as void
		oGenerator:AddLine("//------------------------------------------------------------------------------")
		oGenerator:AddLine("//  <auto-generated>")
		oGenerator:AddLine("//     This code was generated by a tool.")
		oGenerator:AddLine("//     Runtime version: " + Environment.Version:ToString())
		oGenerator:AddLine("//     Generator      : "+cTool+" " + typeof(XFuncs):Assembly:GetName():Version:ToString())
		oGenerator:AddLine("//     Timestamp      : " + System.DateTime.Now:ToString())
		oGenerator:AddLine("//     ")
		oGenerator:AddLine("//     Changes to this file may cause incorrect behavior and may be lost if")
		oGenerator:AddLine("//     the code is regenerated.")
		oGenerator:AddLine("//  </auto-generated>")
		oGenerator:AddLine("//------------------------------------------------------------------------------")
		oGenerator:AddLine("")

	STATIC METHOD EnsureFileNodeExists(oXproject as XSharpModel.XProject , fileName as STRING) AS VOID
		IF !System.IO.File.Exists(fileName)
			System.IO.File.WriteAllText(fileName,"")
		END IF
		if !oXProject:ProjectNode:HasFileNode(fileName)
			oXProject:ProjectNode:AddFileNode(fileName)
		endif

	STATIC METHOD DeleteFile(oXproject as XSharpModel.XProject , cFile as STRING) AS VOID
		if oXProject:ProjectNode:HasFileNode(cFile)
			oXProject:ProjectNode:DeleteFileNode(cFile)
		endif
		oXProject:RemoveFile(cFile)
		IF System.IO.File.Exists(cFile)
			TRY
				System.IO.File.Delete(cFile)
			END TRY
		END IF
END CLASS

	