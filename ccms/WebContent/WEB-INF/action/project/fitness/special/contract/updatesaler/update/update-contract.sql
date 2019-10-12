UPDATE cc_contract 
SET 
	salemember = ${fld:vc_salemember}
	,salemember1 = ${fld:vc_salemember1} 
WHERE code = ${fld:vc_contractcode} and org_id = ${def:org}
