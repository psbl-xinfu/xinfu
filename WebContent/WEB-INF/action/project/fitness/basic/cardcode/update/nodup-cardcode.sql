SELECT 1 FROM cc_cardcode
WHERE cardcode = ${fld:cardcode} 
AND status = 1 AND tuid != ${fld:tuid} and org_id = ${def:org}
