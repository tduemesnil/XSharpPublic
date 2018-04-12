//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//

/// <summary>
/// Extract a line of text from a string.
/// </summary>
/// <param name="cMemo"></param>
/// <param name="wWidth"></param>
/// <param name="wLineNum"></param> 
/// <param name="wTabSize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function MemoLine(cMemo as string,wWidth as long,wLineNum as long,wTabSize as long,lWrap as logic) as string
	/// THROW NotImplementedException{}
	return String.Empty   

/// <summary>
/// Return the contents of a text file as a string.
/// </summary>
/// <param name="cFile"></param>
/// <returns>
/// </returns>
function MemoRead(cFile as string) as string
	LOCAL cResult as STRING
	local lOk as logic
	try
		if File(cFile)
			cFile := FPathName()
			cResult := System.IO.File.ReadAllText(cFile)
		else
			cResult := ""
		endif
	catch
		cResult := ""
	end try
	return cResult



/// <summary>
/// Write a string to a disk file.
/// </summary>
/// <param name="cFile"></param>
/// <param name="c"></param>
/// <returns>
/// </returns>
function MemoWrit(cFile as string,c as string) as logic
	local lOk as logic
	try
		System.IO.File.WriteAllText(cFile, c)
		lOk := TRUE
	catch
		lOk := FALSE
	end try
	RETURN lOk

/// <summary>
/// Count the number of lines in a string.
/// </summary>
/// <param name="cMemo"></param>
/// <returns>
/// </returns>
function MlCount1(cMemo as string) as dword
RETURN MemLines(cMemo)
 

/// <summary>
/// Determine the position of a line in a string.
/// </summary>
/// <param name="c"></param>
/// <param name="nLine"></param>
/// <returns>
/// </returns>
function MLPos2(c as string,nLine as dword) as dword
	return 0   



