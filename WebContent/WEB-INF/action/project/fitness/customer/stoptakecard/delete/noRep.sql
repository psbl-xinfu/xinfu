select 1 from cc_savestopcard
where code in (select regexp_split_to_table(${fld:id},';') from dual) 
and org_id = ${def:org} and status!=10
