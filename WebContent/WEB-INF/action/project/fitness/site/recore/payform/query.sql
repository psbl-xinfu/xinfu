select
	sdef.sitename,
	sd.prepare_date,
	(SELECT config.param_text FROM cc_config config WHERE config.CATEGORY = 'sitetype' and config.param_value::varchar = sdef.sitetype
		and config.org_id = (case when not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) ORDER BY config.tuid) as sitetype,
	(case when cust.name is not null then cust.name when guest.name is not null then guest.name else sd.customername end) as name,
	(case when cust.mobile is not null then cust.mobile when guest.mobile is not null then guest.mobile else sd.mobile end) as mobile,
	(select groupname from cc_guest_group where tuid = sd.guestgroupid and org_id = ${def:org}) as guestgroupid,
	sd.customercode,
	(case when sd.status=0 then '已取消'
		  when sd.status=1 then '已预约' 
		  when sd.status=2 then '已开场' 
		  when sd.status=3 then '已离场' 
		  when sd.status=4 then '已爽约' 
		  when sd.status=5 then '已付款' 
	end) as status,
	to_char(sd.prepare_starttime, 'HH24:mi') as prepare_starttime,
	to_char(sd.prepare_endtime, 'HH24:mi') as prepare_endtime,
	sd.starttime,
	sd.endtime,
	sd.remark,
	sd.premoney,
	sd.pretimes,
	sd.times,
	sd.inimoney,
	sd.normalmoney,
	sd.factmoney
from cc_siteusedetail sd
left join cc_sitedef sdef on sd.sitecode = sdef.code and sd.org_id = sdef.org_id
left join cc_customer cust on sd.customercode = cust.code and sd.org_id = cust.org_id
left join cc_guest guest on sd.customercode = guest.code and sd.org_id = guest.org_id
where sd.org_id = ${def:org} and sd.code = ${fld:code}
