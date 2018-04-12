//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
#include "GetSet.xh"
using XSharp


/// <summary>
/// Return and the setting that determines whether database files are created using ANSI or OEM format and whether certain text file operations convert between the two character sets.
/// </summary>
/// <returns>
/// </returns>
function GetAnsi() as logic
	return RuntimeState.Ansi
	
	
	/// <summary>
	/// </summary>
	/// <param name="pBuffer"></param>
	/// <param name="nSize"></param>
	/// <returns>
	/// </returns>
	//FUNCTION GetCallStack(pBuffer AS Psz,nSize AS INT) AS LOGIC
	/// THROW NotImplementedException{}
	//RETURN FALSE   
	
	/// <summary>
	/// </summary>
	/// <param name="b1"></param>
	/// <param name="b2"></param>
	/// <param name="b3"></param>
	/// <param name="nPad"></param>
	/// <returns>
	/// </returns>
function GetChunkBase64(b1 as byte,b2 as byte,b3 as byte,nPad as int) as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	/// <summary>
	/// Get the current <%APP%> search path for opening file.
	/// </summary>
	/// <returns>
	/// </returns>
function GetCurPath() as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	/// <summary>
	/// </summary>
	/// <returns>
	/// </returns>
function GetDASPtr() as IntPtr
	/// THROW NotImplementedException{}
	return IntPtr.Zero   
	
	
	/// <summary>
	/// Return the <%APP%> default drive and directory.
	/// </summary>
	/// <returns>
	/// </returns>
function GetDefault() as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	/// <summary>
	/// Return the current SetDefaultDir() setting.
	/// </summary>
	/// <returns>
	/// </returns>
function GetDefaultDir() as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
 




	

function GetMimType(c as string) as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	/// <summary>
	/// Get the current DLL for nation-dependent operations and messages.
	/// </summary>
	/// <returns>
	/// </returns>
function GetNatDLL() as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	
	/// <summary>
	/// Returns a string representing the evening extension for time strings in 12-hour format.
	/// </summary>
	/// <returns>
	/// </returns>
function GetPMExt() as string
	getstate string Set.PmExt
	
	
	/// <summary>
	/// </summary>
	/// <returns>
	/// </returns>
function GetRTFullPath() as string
	/// THROW NotImplementedException{}
	return String.Empty   
	
	
	/// <summary>
	/// </summary>
	/// <param name="dwRes"></param>
	/// <returns>
	/// </returns>
function GetStringDXAX(dwRes as dword) as string
	/// THROW NotImplementedException{}
	return String.Empty
	
	/// <summary>
	/// </summary>
	/// <returns>
	/// </returns>
function GetThreadCount() as dword
	/// THROW NotImplementedException{}
	return 0   
	
	/// <summary>
	/// Get the number of 1/10000 seconds that have elapsed since Windows was started.
	/// </summary>
	/// <returns>
	/// </returns>
function GetTickCountLow() as dword
	RETURN (DWORD)Environment.TickCount*10	
	/// <summary>
	/// Return the current separation character used in time strings.
	/// </summary>
	/// <returns>
	/// </returns>
function GetTimeSep() as dword
	getstate dword Set.TimeSep
	
	/// <summary>
	/// Returns TimeZone difference for current timezone in Hours
	/// </summary>
	/// <returns>
	/// </returns>
function GetTimeZoneDiff() as int
return TimeZoneInfo.Local.BaseUtcOffSet:Hours
