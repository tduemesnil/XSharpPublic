﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
using XSharp
/// <summary>

/// <summary>
/// Replace carriage-return/linefeeds with a character that can be displayed.
/// </summary>
/// <param name="cSource"></param>
/// <param name="nCharHard"></param>
/// <param name="nCharSoft"></param>
/// <returns>
/// </returns>
function MemoTran(cSource as Usual,nCharHard as Usual,nCharSoft as Usual) as string
    /// THROW NotImplementedException{}
    return String.Empty   


/// <summary>
/// Count the number of lines in a string.
/// </summary>
/// <param name="c"></param>
/// <param name="nWidth"></param>
/// <param name="nTabsize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function MLCount(c as Usual,nWidth as Usual,nTabsize as Usual,lWrap as Usual) as dword
    /// THROW NotImplementedException{}
    return 0   

/// <summary>
/// Extract a line of text from a string, specifying an optional offset argument.
/// </summary>
/// <param name="c"></param>
/// <param name="nLine"></param>
/// <param name="nOffset"></param>
/// <returns>
/// </returns>
function MLine(c as Usual,nLine as Usual,nOffset as Usual) as string
    /// THROW NotImplementedException{}
    return String.Empty   



/// <summary>
/// Return the position of a character in a formatted string.
/// </summary>
/// <param name="cMemo"></param>
/// <param name="nWidth"></param>
/// <param name="nLineNum"></param>
/// <param name="nCol"></param>
/// <param name="nTabSize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function MLcToPos(cMemo as Usual,nWidth as Usual,nLineNum as Usual,nCol as Usual,nTabSize as Usual,lWrap as Usual) as dword
    /// THROW NotImplementedException{}
    return 0   

/// <summary>
/// Extract a line of text from a string, specifying a required offset argument.
/// </summary>
/// <param name="c"></param>
/// <param name="nLine"></param>
/// <param name="PtrN"></param>
/// <returns>
/// </returns>
function MLine3(c as string,nLine as dword,PtrN as Usual) as string
    /// THROW NotImplementedException{}
    return String.Empty   


/// <summary>
/// Determine the position of a line in a string.
/// </summary>
/// <param name="cMemo"></param>
/// <param name="nWidth"></param>
/// <param name="nLineNum"></param>
/// <param name="nTabSize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function MLPos(cMemo as Usual,nWidth as Usual,nLineNum as Usual,nTabSize as Usual,lWrap as Usual) as dword
    /// THROW NotImplementedException{}
    return 0   

/// <summary>
/// Return the line and column position of a character in a formatted string.
/// </summary>
/// <param name="cMemo"></param>
/// <param name="nWidth"></param>
/// <param name="nPos"></param>
/// <param name="nTabSize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function MPosToLc(cMemo as Usual,nWidth as Usual,nPos as Usual,nTabSize as Usual,lWrap as Usual) as Array
    /// THROW NotImplementedException{}
    return null_array   


/// <summary>
/// </summary>
/// <param name="ptrLine"></param>
/// <param name="nLen"></param>
/// <param name="nLimit"></param>
/// <param name="nTabSize"></param>
/// <param name="lWrap"></param>
/// <returns>
/// </returns>
function LineLen(ptrLine as byte[],nLen as dword,nLimit as dword,nTabSize as dword,lWrap as logic) as dword
    /// THROW NotImplementedException{}
    return 0  