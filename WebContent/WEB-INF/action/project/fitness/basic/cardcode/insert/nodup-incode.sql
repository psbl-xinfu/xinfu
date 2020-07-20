SELECT 1 FROM cc_cardcode
WHERE incode = ${fld:incode} 
AND status = 1 and org_id = ${def:org}
