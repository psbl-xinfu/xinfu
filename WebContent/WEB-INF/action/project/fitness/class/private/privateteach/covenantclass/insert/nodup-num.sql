select 1 from dual where 
 (select ptleftcount from cc_ptrest where code = ${fld:ptcode} and org_id = ${def:org})-
 (select count(1) from cc_ptprepare where ptrestcode = ${fld:ptcode} and status = 1 and org_id = ${def:org})
 <1

 