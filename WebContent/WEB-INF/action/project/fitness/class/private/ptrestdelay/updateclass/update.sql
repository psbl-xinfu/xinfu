update cc_ptrest
set 
	ptleftcount = ${fld:updateclass}::integer,
	
	ptfactfee=${fld:ptfactfee}
where code = ${fld:code} and org_id = ${def:org}