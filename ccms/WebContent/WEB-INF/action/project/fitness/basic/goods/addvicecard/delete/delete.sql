delete from cc_goods_price
where tuid::varchar in (select regexp_split_to_table(${fld:id},',') from dual) 
and org_id = ${def:org}
