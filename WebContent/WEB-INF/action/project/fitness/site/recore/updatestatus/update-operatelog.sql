update cc_operatelog set 
	status=0
where opertype='80'
and pk_value::varchar in (select regexp_split_to_table(${fld:code},',') from dual) 
and org_id = ${def:org} and ${fld:status}='0'

	
