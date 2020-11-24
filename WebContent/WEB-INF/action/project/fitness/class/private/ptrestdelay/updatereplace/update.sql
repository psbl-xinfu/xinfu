update cc_ptrest
set 
	ptleftcount='0'::int
where code = ${fld:code} and org_id = ${def:org}