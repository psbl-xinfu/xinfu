update cc_guest
set mc = '${def:user}'
where code in 
(select guestcode from cc_public where tuid::varchar in (select regexp_split_to_table(${fld:guest},';') from dual) 
and org_id = ${def:org})
and org_id = ${def:org}