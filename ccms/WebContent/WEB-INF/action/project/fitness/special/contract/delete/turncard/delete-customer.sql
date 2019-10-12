DELETE FROM cc_customer c 
WHERE code = (
	SELECT customercode FROM cc_contract r 
	WHERE r.code = ${fld:vc_code} and org_id = ${def:org}
) and org_id = ${def:org}

