select 
	type as ftype,
	item as fitem,
	(select domain_text_cn from t_domain where "namespace"='FinanceType' and domain_value=type::varchar) as type,
	(select domain_text_cn from t_domain where "namespace"='FinanceItem' and domain_value=item::varchar) as item,
	count(1) as num,
	round(sum(premoney)::numeric(10, 2), 2) as premoney,
	round(sum(money)::numeric(10, 2), 2) as money,
	round((sum(premoney)+sum(money))::numeric(10, 2), 2) as totalmoney,
	round(sum(moneyleft)::numeric(10, 2), 2) as moneyleft
from cc_finance
where org_id = ${def:org}
${filter}
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else salesman = '${def:user}' end)
and type is not null and item is not null
GROUP BY type,item
${orderby}