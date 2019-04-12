(select 
		concat('<input type="radio" name="inleftcode" inlefttype="', inleft.inlefttype,'" code="1" value="', inleft.code, '" code3="',
		(select cabinettempcode from cc_cabinettemp where tuid::varchar = inleft.cabinettempcode and org_id = ${def:org}),
		'" code2="',(case when inleft.lefttime is null then  
		(case when inleft.cabinettempcode is null then '0' else '1' end) else '0' end),'" code4="',
		(case when inleft.lefttime is null then '1' else '0' end),'" code5="',card.org_id,'" code6="',ct.type,
		'" code7="',inleft.signednumber,'" code8="',inleft.cardcode,'" code9="',cust.code,'" code10="',inleft.code,'" />') AS checklink,
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
		signednumber,
		--concat((select (inleft.intime::date + ('1 d')::interval))::date, ' 00:00:00')::date as presencedate,
		card.startdate,
		card.enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		(case when inleft.indate is null and inleft.lefttime is not null 
		then inleft.lefttime::date else 
			inleft.indate
		end) as indate
from cc_inleft inleft
left join cc_card card on card.code=inleft.cardcode and card.isgoon = 0 and inleft.customercode=card.customercode--and card.org_id = inleft.org_id
left join cc_cardtype ct on card.cardtype = ct.code --and card.org_id = ct.org_id
left join cc_customer cust on card.customercode = cust.code and inleft.customercode=cust.code--and card.org_id = cust.org_id  2019-3-26 zyb 同一个品牌下可以带出所有的卡（非同店卡带不出来），不同品牌是带不出所有的卡（包括卡号一样的）。
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 1
${filter} 
and (case when ${fld:temporaryinleft} is null then 1=1 else 1=2 end)
and (case when ${fld:inlefttype} is null then 1=1 else 
		(case when ${fld:inlefttype}='1' then 1=1 else 1=2 end) end)
and inleft.guestcode is null
and (case when ${fld:vc_cardcode} is null then 1=1 else (card.code = ${fld:vc_cardcode} or cust.name like concat('%', ${fld:vc_cardcode}, '%')
	 or cust.mobile like concat('%', ${fld:vc_cardcode}, '%'))  end)
)

union

(select 
		concat('<input type="radio" name="inleftcode" code="2" value="', inleft.code, '" code3="',
		(select cabinettempcode from cc_cabinettemp where tuid::varchar = inleft.cabinettempcode and org_id = ${def:org}),
		'" code2="',(case when inleft.lefttime is null then  
		(case when inleft.cabinettempcode is null then '0' else '1' end) else '0' end),'" code4="',
		(case when inleft.lefttime is null then '1' else '0' end),'" code5="',guest.org_id,'" />') AS checklink,
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
		signednumber,
		null as startdate,
		null as enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		(case when inleft.indate is null and inleft.lefttime is not null 
		then inleft.lefttime::date else 
			inleft.indate
		end) as indate
from cc_inleft inleft
left join cc_guest guest on inleft.guestcode = guest.code and inleft.org_id = guest.org_id
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 1
and (case when ${fld:inlefttype} is null then 1=1 else 
		(case when ${fld:inlefttype}='0' then 1=1 else 1=2 end) end)
${filter} 
and (case when ${fld:vc_cardcode} is null then 1=1 else (guest.code = ${fld:vc_cardcode} or guest.name like concat('%', ${fld:vc_cardcode}, '%')
	 or guest.mobile like concat('%', ${fld:vc_cardcode}, '%'))  end)
	 
and inleft.guestcode is not null
)

union

(select 
		concat('<input type="radio" name="inleftcode" inlefttype="', inleft.inlefttype,'" code="1" value="', inleft.code, '" code3="',
		(select cabinettempcode from cc_cabinettemp where tuid::varchar = inleft.cabinettempcode and org_id = ${def:org}),
		'" code2="',(case when inleft.lefttime is null then  
		(case when inleft.cabinettempcode is null then '0' else '1' end) else '0' end),'" code4="',
		(case when inleft.lefttime is null then '1' else '0' end),'" code5="',expercard.org_id,'" />') AS checklink,
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
		signednumber,
		elist.startdate,
		elist.enddate,
		inleft.lefttime as jslefttime,
		inleft.intime as jsintime,
		(case when inleft.indate is null and inleft.lefttime is not null 
		then inleft.lefttime::date else 
			inleft.indate
		end) as indate
from cc_inleft inleft
left join cc_expercard_list elist on elist.code=inleft.cardcode and elist.org_id = inleft.org_id
left join cc_expercard expercard on elist.expercarddef_code = expercard.code and elist.org_id = expercard.org_id
left join cc_expercard_log elog on inleft.customercode = elog.code and inleft.org_id = elog.org_id
left join hr_staff staff on staff.userlogin=inleft.inuser
where  1=1 and inleft.org_id = ${def:org} and inleft.inlefttype = 2
${filter} 
and (case when ${fld:temporaryinleft} is null then 1=1 else 1=2 end)
and (case when ${fld:inlefttype} is null then 1=1 else 
		(case when ${fld:inlefttype}='2' then 1=1 else 1=2 end) end)
and inleft.guestcode is null
and (case when ${fld:vc_cardcode} is null then 1=1 else (elist.code = ${fld:vc_cardcode} or elog.name like concat('%', ${fld:vc_cardcode}, '%')
	 or elog.mobile like concat('%', ${fld:vc_cardcode}, '%'))  end)
)

${orderby}

