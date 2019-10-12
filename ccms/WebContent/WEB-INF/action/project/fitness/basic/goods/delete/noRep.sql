-- modified by zzn 190522 商品删除时增加库存的验证
select 1 from cc_goods_stock
where goodsid::varchar in (select regexp_split_to_table(${fld:id},',') from dual)
and org_id = ${def:org}
and quantity != 0
