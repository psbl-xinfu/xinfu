select 
	config.param_value,
	config.param_text,
	count(1) as num
from cc_config config
inner join cc_guest guest on guest.type::varchar = config.param_value
where config.category = 'GuestType' and guest.org_id = ${def:org}
and guest.status=1 and guest.created::date >= ${fld:fdate} AND guest.created::date <= ${fld:tdate}
and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id =${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
GROUP BY config.param_value,config.param_text
order by count(1) desc


