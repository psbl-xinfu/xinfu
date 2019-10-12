select 1 from dual where 
 (select ptleftcount from cc_ptrest where code = ${fld:code} and org_id = ${def:org})-
 (select count(1) from cc_ptprepare where ptrestcode = ${fld:code} and status = 1 and org_id = ${def:org})
 <1

 