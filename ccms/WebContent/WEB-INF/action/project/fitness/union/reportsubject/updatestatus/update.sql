update cc_report_subject
set status = ${fld:status}
where tuid::varchar in (select regexp_split_to_table(${fld:tuid},',') from dual) 
and org_id = ${def:org}

