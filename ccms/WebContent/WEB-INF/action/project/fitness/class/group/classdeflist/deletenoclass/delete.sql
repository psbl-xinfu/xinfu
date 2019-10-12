delete from cc_classlist
where code in (select regexp_split_to_table(${fld:code},',') from dual) and org_id= ${def:org}
and status !=1

