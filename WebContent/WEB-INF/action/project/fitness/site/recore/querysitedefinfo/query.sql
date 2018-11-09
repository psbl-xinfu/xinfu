select 
	code,
	(case when sd.status=0 then '无效'
		  when sd.status=1 then '已预约' 
		  when sd.status=2 then '已开场' 
		  when sd.status=3 then '已离场' 
		  when sd.status=4 then '已爽约' 
		  when sd.status=5 then '已付款' 
	end) as status,
	sd.prepare_date,
	(SELECT config.param_text FROM cc_config config WHERE config.CATEGORY = 'sitetype' and config.tuid = sdef.sitetype
		and config.org_id = (case when not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) ORDER BY config.tuid) as sitetype,
	sdef.sitename,
	cust.name,
	cust.mobile
from cc_siteusedetail sd
left join cc_sitedef sdef on sd.sitecode = sdef.code and sd.org_id = sdef.org_id
left join cc_customer cust on sd.customercode = cust.code and sd.org_id = cust.org_id
where sd.code = ${fld:querysitedef} and sd.org_id = ${def:org}