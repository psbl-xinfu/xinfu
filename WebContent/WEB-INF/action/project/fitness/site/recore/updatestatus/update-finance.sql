update cc_finance set 
	status=0
where type=3 and item=36 
and operationcode::varchar in (select regexp_split_to_table(${fld:code},',') from dual) 
and org_id = ${def:org} and ${fld:status}='0'

	
