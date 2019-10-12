(select 
		inleft.cardcode,	
		(select cabinettempcode from cc_cabinettemp where tuid::varchar = inleft.cabinettempcode and org_id = ${def:org}) as cabinettempcode,	
		cust.name, 
		cust.code as bianhao, 
		staff.name AS vc_inusername,
		ct.name as vc_type,	
		inleft.intime,			
		inleft.lefttime,
		inleft.code as leftcode,
		inleft.remark,
		concat('星期', (case 
			when extract(DOW FROM inleft.intime)=1 then '一'
			when extract(DOW FROM inleft.intime)=2 then '二'
			when extract(DOW FROM inleft.intime)=3 then '三'
			when extract(DOW FROM inleft.intime)=4 then '四'
			when extract(DOW FROM inleft.intime)=5 then '五'
			when extract(DOW FROM inleft.intime)=6 then '六'
			when extract(DOW FROM inleft.intime)=7 then '日'
		end)) as week,
		--concat((select (inleft.intime::date + ('1 d')::interval))::date, ' 00:00:00')::date as presencedate,
		card.startdate,
		card.enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		inleft.indate
from cc_inleft inleft
left join cc_card card on card.code=inleft.cardcode and card.isgoon = 0 --and card.org_id = inleft.org_id
left join cc_cardtype ct on card.cardtype = ct.code --and card.org_id = ct.org_id
left join cc_customer cust on card.customercode = cust.code --and card.org_id = cust.org_id
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 1
${filter} 
and (case when ${fld:daochu_temporaryinleft} is null then 1=1 else 1=2 end)
and (case when ${fld:daochu_inlefttype} is null then 1=1 else 
		(case when ${fld:daochu_inlefttype}='1' then 1=1 else 1=2 end) end)
and inleft.guestcode is null
and (case when ${fld:daochu_vc_cardcode} is null then 1=1 else (card.code = ${fld:daochu_vc_cardcode} or cust.name like concat('%', ${fld:daochu_vc_cardcode}, '%')
	 or cust.mobile like concat('%', ${fld:daochu_vc_cardcode}, '%'))  end)
)

union

(select 
		inleft.cardcode,	
		'' as cabinettempcode,	
		guest.name, 
		guest.code as bianhao, 
		staff.name AS vc_inusername,
		'临时入场' as vc_type,	
		inleft.intime,			
		inleft.lefttime,
		inleft.code as leftcode,
		inleft.remark,
		concat('星期', (case 
			when extract(DOW FROM inleft.intime)=1 then '一'
			when extract(DOW FROM inleft.intime)=2 then '二'
			when extract(DOW FROM inleft.intime)=3 then '三'
			when extract(DOW FROM inleft.intime)=4 then '四'
			when extract(DOW FROM inleft.intime)=5 then '五'
			when extract(DOW FROM inleft.intime)=6 then '六'
			when extract(DOW FROM inleft.intime)=7 then '日'
		end)) as week,
		null as startdate,
		null as enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		inleft.indate
from cc_inleft inleft
left join cc_guest guest on inleft.guestcode = guest.code and inleft.org_id = guest.org_id
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 1
and (case when ${fld:daochu_inlefttype} is null then 1=1 else 
		(case when ${fld:daochu_inlefttype}='0' then 1=1 else 1=2 end) end)
${filter} 
and (case when ${fld:daochu_vc_cardcode} is null then 1=1 else (guest.code = ${fld:daochu_vc_cardcode} or guest.name like concat('%', ${fld:daochu_vc_cardcode}, '%')
	 or guest.mobile like concat('%', ${fld:daochu_vc_cardcode}, '%'))  end)
	 
and inleft.guestcode is not null
)

union

(select 
		inleft.cardcode,	
		(select cabinettempcode from cc_cabinettemp where tuid::varchar = inleft.cabinettempcode and org_id = ${def:org}) as cabinettempcode,	
		elog.name, 
		elog.code as bianhao, 
		staff.name AS vc_inusername,
		concat(expercard.name, '（体验卡）') as vc_type,	
		inleft.intime,			
		inleft.lefttime,
		inleft.code as leftcode,
		inleft.remark,
		concat('星期', (case 
			when extract(DOW FROM inleft.intime)=1 then '一'
			when extract(DOW FROM inleft.intime)=2 then '二'
			when extract(DOW FROM inleft.intime)=3 then '三'
			when extract(DOW FROM inleft.intime)=4 then '四'
			when extract(DOW FROM inleft.intime)=5 then '五'
			when extract(DOW FROM inleft.intime)=6 then '六'
			when extract(DOW FROM inleft.intime)=7 then '日'
		end)) as week,
		elist.startdate,
		elist.enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		inleft.indate
from cc_inleft inleft
left join cc_expercard_list elist on elist.code=inleft.cardcode and elist.org_id = inleft.org_id
left join cc_expercard expercard on elist.expercarddef_code = expercard.code and elist.org_id = expercard.org_id
left join cc_expercard_log elog on inleft.customercode = elog.code and inleft.org_id = elog.org_id
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 2
${filter} 
and (case when ${fld:daochu_temporaryinleft} is null then 1=1 else 1=2 end)
and (case when ${fld:daochu_inlefttype} is null then 1=1 else 
		(case when ${fld:daochu_inlefttype}='2' then 1=1 else 1=2 end) end)
and inleft.guestcode is null
and (case when ${fld:daochu_vc_cardcode} is null then 1=1 else (elist.code = ${fld:daochu_vc_cardcode} or elog.name like concat('%', ${fld:daochu_vc_cardcode}, '%')
	 or elog.mobile like concat('%', ${fld:daochu_vc_cardcode}, '%'))  end)
)

order by indate desc,intime desc
	