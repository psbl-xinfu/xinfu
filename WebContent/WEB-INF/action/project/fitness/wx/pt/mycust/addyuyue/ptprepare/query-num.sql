select count(1) as num from dual where 
 (select ptleftcount from cc_ptrest where code = ${fld:ptrestcode} and org_id = ${def:org})-
 (select count(1) from cc_ptprepare where ptrestcode = ${fld:ptrestcode} and status = 1 and org_id = ${def:org})
 <1

 