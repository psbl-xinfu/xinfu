select
	config.param_value as param_value,
	config.param_text as param_text,
	sum(c.factmoney)::numeric(10,2) as normalmoney
from cc_config config
inner join cc_operatelog op on op.opertype::int=config.param_value::int
inner join cc_contract c on op.pk_value = c.code and op.org_id = c.org_id
where op.customercode=${fld:id} and op.org_id='${def:org}' and config.category = 'OpeCategory'
and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id =${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
GROUP BY param_value,param_text
--zzn 2019-03-29 union商品销售记录
union

select
	config.param_value as param_value,
	config.param_text as param_text,
	sum(op.factmoney)::numeric(10,2) as normalmoney
from cc_config config
inner join cc_operatelog op on op.opertype::int=config.param_value::int
where op.customercode=${fld:id} and op.org_id='${def:org}' and config.category = 'OpeCategory'
and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id =${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
GROUP BY param_value,param_text

order by normalmoney desc

