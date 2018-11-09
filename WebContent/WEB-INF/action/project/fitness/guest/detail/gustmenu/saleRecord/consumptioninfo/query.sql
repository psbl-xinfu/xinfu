select
	config.param_value,
	config.param_text,
	sum(c.factmoney) as normalmoney
from cc_config config
inner join cc_operatelog op on op.opertype::int=config.param_value::int
inner join cc_contract c on op.pk_value = c.code and op.org_id = c.org_id
where op.customercode=${fld:id} and op.org_id='${def:org}' and config.category = 'OpeCategory'
and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id =${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
GROUP BY config.param_value,config.param_text
order by sum(c.factmoney) desc

