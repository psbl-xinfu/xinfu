SELECT code 
FROM cc_ptprepare 
WHERE ptid = (select ptid from cc_ptrest where code = ${fld:ptcode})
AND preparedate = ${fld:pdate}::date AND preparetime = (${fld:hour} ||':'||${fld:minute})::time 
AND status = 1
 and org_id = ${def:org}
