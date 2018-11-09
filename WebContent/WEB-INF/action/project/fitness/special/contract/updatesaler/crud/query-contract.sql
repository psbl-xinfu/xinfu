SELECT 
	t.code as vc_code
	,t.salemember as vc_salemember
	,t.salemember1 as vc_salemember1
FROM cc_contract t 
WHERE t.code = ${fld:vc_code} and org_id = ${def:org} 

