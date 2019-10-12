delete from cc_site_timelimit 
where
	code = ${fld:site_timelimitcode} and org_id = ${def:org}
	and ${fld:choose_way}='0'

	
