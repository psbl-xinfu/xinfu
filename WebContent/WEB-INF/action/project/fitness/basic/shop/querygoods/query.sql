select 
	goods.tuid as goodid,
	goods.goods_name,
	goods.standard,
	(select	domain_text_cn from t_domain where "namespace"='goodUnit' and domain_value = unit and is_enabled = '1' ) as unit,
	gp.price,
	gp.tuid as gptuid,
	gp.staff_price,
	gp.storageid
from cc_goods_price gp
inner join cc_goods goods on gp.goodsid = goods.tuid and gp.org_id = goods.org_id
where gp.tuid = ${fld:searchgptuid} and gp.org_id = ${def:org}
