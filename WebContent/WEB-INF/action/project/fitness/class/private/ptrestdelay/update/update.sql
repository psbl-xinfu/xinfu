update cc_ptrest
set 
	ptenddate = ptenddate::date+${fld:datetime}::integer
where code = ${fld:code} and org_id = ${def:org}