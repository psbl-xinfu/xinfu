SELECT code 
FROM cc_ptprepare 
WHERE code = ${fld:code}
AND (preparedate != '${def:date}' or status != 1)  and org_id = ${def:org}


