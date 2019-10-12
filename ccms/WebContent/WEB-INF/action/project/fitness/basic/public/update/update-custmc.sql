update cc_customer
set mc = '${def:user}'
where code in 
(select customercode from cc_public where tuid::varchar in (select regexp_split_to_table(${fld:cust},';') from dual) 
and org_id = ${def:org})
and org_id = ${def:org}