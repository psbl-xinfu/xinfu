select
	goods_name,
	fastcode,
	(select	domain_text_cn from t_domain where "namespace"='goodType' and domain_value::integer = goods_type and is_enabled = '1' ) as goods_type,
	(select	domain_text_cn from t_domain where "namespace"='goodUnit' and domain_value = unit and is_enabled = '1' ) as unit,
	standard,
	buyprice
from cc_goods
where org_id = ${def:org} and status = 1
${filter}
order by tuid desc


