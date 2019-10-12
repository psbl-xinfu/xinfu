UPDATE cc_contract 
SET status = 0 
WHERE code = ${fld:vc_code} and org_id = ${def:org}
