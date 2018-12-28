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
	to_char(sd.starttime, 'HH24:mi') as starttime,
	to_char(sd.endtime, 'HH24:mi') as endtime,
	sd.remark,
	sd.premoney,
	sd.pretimes,
	sd.times,
	(select to_char((sd.endtime::time-sd.starttime::time), 'HH24')) as hours,
	((select to_char((sd.endtime::time-sd.starttime::time), 'MI'))::float/60) as minutes,
--	(case when sd.prepare_type='1' then (select ) 
	--) as 
	sd.inimoney,--原价
	(sd.normalmoney-sd.deposit) as normalmoney,
	sd.factmoney,
	sd.deposit,
	to_char((sd.endtime-sd.starttime), 'HH24:mi') as totaltime,
	(case when sd.prepare_type = '1' then sdef.block_price
	when sd.prepare_type = '2' then sdef.group_price end) as price,
	(case when sd.prepare_type = '1' then '(包场)'
	when sd.prepare_type = '2' then '(拼场)' end) as bpprice,
	sd.prepare_type,
	(case when sd.customertype='2' then (select count(groupid) as groupidnumber from cc_guest_group_member where groupid=sd.guestgroupid )
	else '1' end) as thenumber
	from cc_siteusedetail sd
left join cc_sitedef sdef on sd.sitecode = sdef.code and sd.org_id = sdef.org_id
left join cc_customer cust on sd.customercode = cust.code and sd.org_id = cust.org_id
left join cc_guest guest on sd.customercode = guest.code and sd.org_id = guest.org_id
where sd.org_id = ${def:org} and sd.code = ${fld:code}
