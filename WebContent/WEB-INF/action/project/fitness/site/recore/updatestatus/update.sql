update cc_siteusedetail set 
	status=${fld:status}
where code::varchar in (select regexp_split_to_table(${fld:code},',') from dual) 
and org_id = ${def:org}

	
