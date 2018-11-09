SELECT
    code as userlogin,
	ptlevelname as vc_ptlevel
FROM
	cc_ptdef
where org_id = ${def:org}
and status!=0