select
	sd.code,
	sdef.sitename,
	sd.prepare_date,
	(SELECT config.param_text FROM cc_config config WHERE config.CATEGORY = 'sitetype' and config.param_value::varchar = sdef.sitetype
		and config.org_id = (case when not exists(select 1 from cc_config c where c.org_id = sd.org_id and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else sd.org_id end) ORDER BY config.tuid) as sitetype,
	(case when cust.name is not null then cust.name when guest.name is not null then guest.name else sd.customername end) as name,
	(case when cust.mobile is not null then cust.mobile when guest.mobile is not null then guest.mobile else sd.mobile end) as mobile,
	(case when sd.prepare_type=1 then '包场' when sd.prepare_type=2 then '拼场' end) as prepare_type,
	to_char(prepare_starttime, 'HH24:mi') as prepare_starttime,
	to_char(prepare_endtime, 'HH24:mi') as prepare_endtime,
	(select groupname from cc_guest_group where tuid = sd.guestgroupid and org_id = sd.org_id) as groupname,
	sd.normalmoney,
	sd.paystatus,
	(case when (sd.prepare_date::date<'${def:date}'::date and sd.status=1 and sd.paystatus=0) then 0 else 1 end) as zfstatus
from cc_siteusedetail sd
left join cc_sitedef sdef on sd.sitecode = sdef.code and sd.org_id = sdef.org_id
left join cc_customer cust on sd.customercode = cust.code and sd.org_id = cust.org_id
left join cc_guest guest on sd.customercode = guest.code and sd.org_id = guest.org_id
where customercode in (case when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
			then (select code from cc_customer where user_id = (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) )
			when (select code from cc_guest where weixinlogin = ${fld:weixin_userid}) is not null
			then (select code from cc_guest where weixinlogin = ${fld:weixin_userid} )
		end)
order by sd.created desc
