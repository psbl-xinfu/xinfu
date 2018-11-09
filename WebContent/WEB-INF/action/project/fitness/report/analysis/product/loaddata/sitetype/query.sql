select 
	(SELECT config.param_text FROM cc_config config WHERE config.CATEGORY = 'sitetype' and config.param_value::varchar = sd.sitetype::varchar
		and config.org_id = (case when not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) ORDER BY config.tuid) as sitetype,
	count(s.*) as num
from cc_sitedef sd
left join cc_siteusedetail s on sd.code = s.sitecode and sd.org_id = s.org_id
where s.paystatus = 1 and (s.status = 2 or s.status = 3) and sd.org_id = ${def:org}
and s.prepare_date::date >= ${fld:fdate} AND s.prepare_date::date <= ${fld:tdate} 
GROUP BY sd.sitetype
order by count(s.*) desc

