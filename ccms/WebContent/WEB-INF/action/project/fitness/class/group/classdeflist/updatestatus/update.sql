update cc_classlist
set
	status=1
where code in (select regexp_split_to_table(${fld:code},',') from dual)
and org_id= ${def:org}








