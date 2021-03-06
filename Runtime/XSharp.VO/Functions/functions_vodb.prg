//
// Copyright (c) XSharp B.V.  All Rights Reserved.  
// Licensed under the Apache License, Version 2.0.  
// See License.txt in the project root for license information.
//
using XSharp
using XSharp.RDD

/// <summary>
/// Get the contents of a field that is identified by its work area and a __Symbol.
/// </summary>
/// <param name="dwArea"></param>
/// <param name="symField"></param>
/// <returns>
/// </returns>
FUNCTION FieldGetArea(dwArea AS DWORD,symField AS __Symbol) AS __Usual
	THROW NotImplementedException{}
RETURN __Usual._NIL   


/// <summary>
/// Set the value of a field identified by its work area number and field name.
/// </summary>
/// <param name="dwArea"></param>
/// <param name="symField"></param>
/// <param name="u"></param>
/// <returns>
/// </returns>
FUNCTION FieldPutArea(dwArea AS DWORD,symField AS __Symbol,u AS __Usual) AS __Usual
	THROW NotImplementedException{}
RETURN __Usual._NIL   



/// <summary>
/// Return the name of a field as a __Symbol.
/// </summary>
/// <param name="dwPos"></param>
/// <returns>
/// </returns>
FUNCTION FieldSym(dwPos AS DWORD) AS __Symbol
	THROW  NotImplementedException{}
RETURN NULL_SYMBOL   





/// <summary>
/// Return the alias of a specified work area as a symbol.
/// </summary>
/// <param name="nArea"></param>
/// <returns>
/// </returns>
FUNCTION VODBAliasSym(nArea AS DWORD) AS __SYMBOL
	THROW  NotImplementedException{}
RETURN NULL_SYMBOL   


/// <summary>
/// </summary>
/// <param name="nOrdinal"></param>
/// <param name="nPos"></param>
/// <param name="ptrRet"></param>
/// <returns>
/// </returns>
FUNCTION VODBBlobInfo(nOrdinal AS DWORD,nPos AS DWORD,ptrRet REF OBJECT) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Evaluate a code block for each record that matches a specified scope and/or condition.
/// </summary>
/// <param name="uBlock"></param>
/// <param name="uCobFor"></param>
/// <param name="uCobWhile"></param>
/// <param name="nNext"></param>
/// <param name="nRecno"></param>
/// <param name="lRest"></param>
/// <returns>
/// </returns>
FUNCTION VODBEval(uBlock AS __Usual,uCobFor AS __Usual,uCobWhile AS __Usual,nNext AS __Usual,nRecno AS __Usual,lRest AS LOGIC) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Retrieve field definition information about a field.
/// </summary>
/// <param name="nOrdinal"></param>
/// <param name="nPos"></param>
/// <param name="ptrRet"></param>
/// <returns>
/// </returns>
FUNCTION VODBFieldInfo(nOrdinal AS DWORD,nPos AS DWORD,value REF __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Set the value of a specified database field.
/// </summary>
/// <param name="nPos"></param>
/// <param name="xValue"></param>
/// <returns>
/// </returns>
FUNCTION VODBFieldPut(nPos AS DWORD,xValue AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Return the work area number.
/// </summary>
/// <returns>
/// </returns>
FUNCTION VODBGetSelect() AS INT
	THROW  NotImplementedException{}
RETURN 0   

/// <summary>
/// Move to the last logical record.
/// </summary>
/// <returns>
/// </returns>
FUNCTION VODBGoBottom() AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Move to a record specified by record number.
/// </summary>
/// <param name="uRecId"></param>
/// <returns>
/// </returns>
FUNCTION VODBGoto(uRecId AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Move to the first logical record.
/// </summary>
/// <returns>
/// </returns>
FUNCTION VODBGoTop() AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Retrieve information about a work area.
/// </summary>
/// <param name="nOrdinal"></param>
/// <param name="ptrRet"></param>
/// <returns>
/// </returns>
FUNCTION VODBInfo(nOrdinal AS DWORD,ptrRet REF OBJECT) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Search for the first record that matches a specified condition and scope.
/// </summary>
/// <param name="uCobFor"></param>
/// <param name="uCobWhile"></param>
/// <param name="nNext"></param>
/// <param name="uRecId"></param>
/// <param name="lRest"></param>
/// <returns>
/// </returns>
FUNCTION VODBLocate(uCobFor AS __Usual,uCobWhile AS __Usual,nNext AS LONG,uRecId AS __Usual,lRest AS LOGIC) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   



/// <summary>
/// Create or replace an order in an index file.
/// </summary>
/// <param name="cBagName"></param>
/// <param name="uOrder"></param>
/// <param name="cExpr"></param>
/// <param name="uCobExpr"></param>
/// <param name="lUnique"></param>
/// <param name="ptrCondInfo"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrdCreate(cBagName AS STRING,uOrder AS __Usual,cExpr AS STRING,uCobExpr AS __Usual,lUnique AS LOGIC,ptrCondInfo AS DbOrderCondInfo) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Remove an order from an open index file.
/// </summary>
/// <param name="cOrdBag"></param>
/// <param name="uOrder"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrdDestroy(cOrdBag AS STRING,uOrder AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Return information about index files and the orders in them.
/// </summary>
/// <param name="nOrdinal"></param>
/// <param name="cBagName"></param>
/// <param name="uOrder"></param>
/// <param name="ptrRet"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrderInfo(nOrdinal AS DWORD,cBagName AS STRING,uOrder AS __Usual,ptrRet REF OBJECT) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// </summary>
/// <param name="ost"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrderStatus(ost AS ORDERSTATUS) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Open an index file and add specified orders to the order list in a work area.
/// </summary>
/// <param name="cOrdBag"></param>
/// <param name="uOrder"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrdListAdd(cOrdBag AS STRING,uOrder AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Remove orders from the order list in a work area and close associated index files.
/// </summary>
/// <param name="cOrdBag"></param>
/// <param name="uOrder"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrdListClear(cOrdBag AS STRING,uOrder AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Set the controlling order for a work area.
/// </summary>
/// <param name="cOrdBag"></param>
/// <param name="uOrder"></param>
/// <param name="pszOrder"></param>
/// <returns>
/// </returns>
FUNCTION VODBOrdSetFocus(cOrdBag AS STRING,uOrder AS __Usual,pszOrder AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Return the current record number.
/// </summary>
/// <returns>
/// </returns>
FUNCTION VODBRecno() AS __Usual
	THROW  NotImplementedException{}
RETURN __Usual._NIL   


/// <summary>
/// Retrieve information about a record.
/// </summary>
/// <param name="nOrdinal"></param>
/// <param name="uRecId"></param>
/// <param name="ptrRet"></param>
/// <returns>
/// </returns>
FUNCTION VODBRecordInfo(nOrdinal AS DWORD,uRecId AS __Usual,ptrRet REF Object) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// </summary>
/// <param name="pszRecord"></param>
/// <returns>
/// </returns>
FUNCTION VODBRecordPut(pszRecord AS __Psz) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Return the linking expression of a specified relation.
/// </summary>
/// <param name="nPos"></param>
/// <param name="pszRel"></param>
/// <returns>
/// </returns>
FUNCTION VODBRelation(nPos AS DWORD,pszRel AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Lock the current record.
/// </summary>
/// <param name="uRecId"></param>
/// <returns>
/// </returns>
FUNCTION VODBRlock(uRecId AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Move to the record having the specified key value.
/// </summary>
/// <param name="xValue"></param>
/// <param name="lSoft"></param>
/// <returns>
/// </returns>
FUNCTION VODBSeek(xValue AS __Usual,lSoft AS LOGIC) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Select a new work area and retrieve the current work area.
/// </summary>
/// <param name="nNew"></param>
/// <param name="riOld"></param>
/// <returns>
/// </returns>
FUNCTION VODBSelect(nNew AS DWORD,riOld AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Set a filter condition.
/// </summary>
/// <param name="uCobFilter"></param>
/// <param name="cFilter"></param>
/// <returns>
/// </returns>
FUNCTION VODBSetFilter(uCobFilter AS __Usual,cFilter AS STRING) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// Specify the code block for a locate condition.
/// </summary>
/// <param name="uCobFor"></param>
/// <returns>
/// </returns>
FUNCTION VODBSetLocate(uCobFor AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Relate a specified work area to the current work area.
/// </summary>
/// <param name="cAlias"></param>
/// <param name="uCobKey"></param>
/// <param name="cKey"></param>
/// <returns>
/// </returns>
FUNCTION VODBSetRelation(cAlias AS STRING,uCobKey AS __Usual,cKey AS STRING) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   


/// <summary>
/// </summary>
/// <param name="nDest"></param>
/// <param name="fnNames"></param>
/// <param name="uCobFor"></param>
/// <param name="uCobWhile"></param>
/// <param name="nNext"></param>
/// <param name="nRecno"></param>
/// <param name="lRest"></param>
/// <param name="fnSortNames"></param>
/// <returns>
/// </returns>
FUNCTION VODBSort(nDest AS DWORD,fnNames AS DbFIELDNAMES,uCobFor AS __Usual,uCobWhile AS __Usual,;
	nNext AS __Usual,nRecno AS __Usual,lRest AS LOGIC,fnSortNames AS DbFIELDNAMES) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// </summary>
/// <param name="wst"></param>
/// <returns>
/// </returns>
FUNCTION VODBStatus(wst AS DbWORKAREASTATUS) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Select a new work area by specifying its alias as a symbol and return the number of the current work area.
/// </summary>
/// <param name="sAlias"></param>
/// <returns>
/// </returns>
FUNCTION VODBSymSelect(sAlias AS __SYMBOL) AS INT
	THROW  NotImplementedException{}
RETURN 0   

/// <summary>
/// </summary>
/// <param name="nDest"></param>
/// <param name="fldNames"></param>
/// <param name="uCobFor"></param>
/// <param name="uCobWhile"></param>
/// <param name="nNext"></param>
/// <param name="nRecno"></param>
/// <param name="lRest"></param>
/// <returns>
/// </returns>
FUNCTION VODBTrans(nDest AS DWORD,fldNames AS DbFieldNames,uCobFor AS __Usual,uCobWhile AS __Usual,;
	nNext AS __Usual,nRecno AS __Usual,lRest AS LOGIC) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

/// <summary>
/// Release all locks for a work area.
/// </summary>
/// <param name="uRecno"></param>
/// <returns>
/// </returns>
FUNCTION VODBUnlock(uRecno AS __Usual) AS LOGIC
	THROW  NotImplementedException{}
RETURN FALSE   

