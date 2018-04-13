﻿//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//

// functions used by the compiler

/// <summary>
/// Compare 2 strings. This function is used by the compiler for string comparisons
/// </summary>
/// <param name="strLHS">The first string .</param>
/// <param name="strRHS">The second string.</param>
/// <returns>
/// -1 strA precedes strB in the sort order. 
///  0 strA occurs in the same position as strB in the sort order. 
///  1 strA follows strB in the sort order. 
/// Note this this function should respect SetCollation() and SetInternational() and SetExact()
/// </returns>

function __StringCompare(strLHS as string, strRHS as string) as int
	local ret as int
	
	if strLHS == null
		if strRHS == null			// null and null are equal
			ret := 0
		else
			ret := -1				// null precedes a string
		endif
	elseif strRHS == null			// a string comes after null
		ret := 1
	else							// both not null
		// With Not Exact comparison we only compare the length of the RHS string
		if .not. RuntimeState.Exact
			local lengthRHS as int
			lengthRHS := strRHS:Length
			if lengthRHS == 0 
				return 0
			elseif lengthRHS<= strLHS:Length 
				if String.Compare( strLHS, 0, strRHS, 0, lengthRHS , StringComparison.Ordinal ) == 0
					return 0
				endif
			endif
		endif
		// either exact or RHS longer than LHS
		// TODO: Use Clipper Collation based comparison
		ret := String.Compare( strLHS, 0, strRHS, 0, strRHS:Length, StringComparison.Ordinal )
	endif
	return ret


/// <summary>
/// Compare 2 strings. This function is used by the compiler for string comparisons
/// </summary>
/// <param name="strLHS">The first string .</param>
/// <param name="strRHS">The second string.</param>
/// <returns>
/// TRUE when the strings are equal, FALSE when they are not equal
/// This function respects SetExact()
/// </returns>
function  __StringEquals(strLHS as string, strRHS as string) as logic
	local equals := FALSE as logic
	local lengthRHS as int
	
	if RuntimeState.Exact
		equals := strLHS == strRHS
	elseif strLHS != null .and. strRHS != null
		lengthRHS := strRHS:Length
		if lengthRHS == 0
			equals := true        // With SetExact(FALSE) then "aaa" = "" returns TRUE
		elseif lengthRHS <= strLHS:Length
			equals := String.Compare( strLHS, 0, strRHS, 0, lengthRHS, StringComparison.Ordinal ) == 0
		endif
	elseif strLHS == null .and. strRHS == null
		equals := true
	endif
	return equals

/// <summary>
/// Compare 2 strings. This function is used by the compiler for string comparisons
/// </summary>
/// <param name="strLHS">The first string .</param>
/// <param name="strRHS">The second string.</param>
/// <returns>
/// TRUE when the strings are not equal, FALSE when they are equal
/// This function respects SetExact()
/// </returns>
function  __StringNotEquals(strLHS as string, strRHS as string) as logic
	local notEquals := FALSE as logic
	local lengthRHS as int
	
	if RuntimeState.Exact
		notEquals := strLHS != strRHS
	elseif strLHS != null .and. strRHS != null
		lengthRHS := strRHS:Length
		if lengthRHS == 0
			notEquals := false        // With SetExact(FALSE) then "aaa" = "" returns TRUE
		elseif lengthRHS <= strLHS:Length
			notEquals := String.Compare( strLHS, 0, strRHS, 0, lengthRHS, StringComparison.Ordinal ) != 0
		endif
	elseif strLHS == null .and. strRHS == null
		notEquals := false
	else
		notEquals := true
	endif
	return notEquals


/// <summary>
/// Remove leading and trailing spaces from a string.
/// </summary>
/// <param name="c">The string to be trimmed.</param>
/// <returns>
/// The original string without leading and trailing spaces
/// </returns>
// _FIELD->Name
FUNCTION __FieldGet( fieldName AS STRING ) AS USUAL
	return NIL

// CUSTOMER->NAME
FUNCTION __FieldGetWa( alias AS STRING, fieldName AS STRING ) AS USUAL
	return NIL

// _FIELD->Name := "Foo"
FUNCTION __FieldSet( fieldName AS STRING, uValue AS USUAL ) AS USUAL
	return uValue

// CUSTOMER->Name := "Foo"
FUNCTION __FieldSetWa( alias AS STRING, fieldName AS STRING, uValue AS USUAL ) AS USUAL
	return uValue


// MEMVAR myName
// ? MyName
function __MemVarGet(cName as string) as USUAL
	return NIL

// MEMVAR myName
// MyName := "NewValue"
function __MemVarPut(cName as string, uValue as usual) as usual
	return uValue


// ALIAS->(DoSomething())
// is translated to
// __pushWorkarea( alias ) ; DoSomething() ; __popWorkArea()

FUNCTION __pushWorkarea( alias AS USUAL ) AS VOID
	return 

FUNCTION __popWorkarea() AS VOID
   RETURN