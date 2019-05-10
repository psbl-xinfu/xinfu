update cc_ptrest
set 
	ptleftcount = ${fld:updateclass}::integer
where code = ${fld:code} and org_id = ${def:org}