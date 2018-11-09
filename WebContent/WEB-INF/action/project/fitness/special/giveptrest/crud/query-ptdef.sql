SELECT 
	distinct code,
	ptlevelname
FROM cc_ptdef
where org_id = ${def:org}
 