delete from cc_enter_stock_goods
where tuid::varchar in (select regexp_split_to_table(${fld:id},',') from dual) 
and org_id = ${def:org}
