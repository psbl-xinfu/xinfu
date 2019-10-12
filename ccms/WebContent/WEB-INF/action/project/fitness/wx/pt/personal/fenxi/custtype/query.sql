select
	config.param_value,
	config.param_text,
	count(1) as num
from cc_config config
left join cc_customer cust on cust.type::varchar = config.param_value
where config.category = 'GuestType' and cust.org_id = ${def:org}
and cust.status=1 
and cust.created >=${fld:typedate}
and cust.created <=${fld:enddate}

AND EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE cust.code = d.customercode AND d.isgoon = 0 AND d.org_id = cust.org_id AND d.status != 0 AND d.status != 6
) 

AND EXISTS(
	SELECT 1 FROM cc_ptrest t 
	WHERE t.customercode = cust.code AND t.ptleftcount > 0 AND t.pttype != 5 AND t.org_id = cust.org_id AND t.ptid='${def:user}'
) 

and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id =${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
GROUP BY config.param_value,config.param_text



