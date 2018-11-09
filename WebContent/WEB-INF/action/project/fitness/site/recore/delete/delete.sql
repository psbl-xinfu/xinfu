delete from cc_siteusedetail
where code::varchar in (select regexp_split_to_table(${fld:code},',') from dual) 
and org_id = ${def:org}
