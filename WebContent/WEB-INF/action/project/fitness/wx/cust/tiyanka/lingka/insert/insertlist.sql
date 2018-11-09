INSERT INTO cc_expercard_list(
	code,
	market_campaign_code,--营销活动编号
	expercarddef_code,--体验卡定义编号
	expercard_log_code,--体验卡领取记录编号
	
	expertype,
	experlimit,
	startdate,
	enddate,
	
	createdby,
	status,
	created,
	org_id
	) VALUES(
	${fld:expercardcode},
	${fld:code},
	${fld:ecode},
	${seq:currval@seq_cc_expercard_log},
	
	(select  expertype  from cc_expercard where code=${fld:ecode} and org_id = ${fld:org_id}),
	(select  experlimit  from cc_expercard where code=${fld:ecode} and org_id = ${fld:org_id}),
	
	
	(select 
		(
			case 
				when m.startdate is null  then d.startdate --活动空
			else	--活动不空
					(case when d.startdate  is not null then --体验卡不空
							(case when
									m.startdate<d.startdate then m.startdate else d.startdate 
								end)
							else m.startdate
						end)
			end)
		from cc_expercard d 
		left join cc_market_campaign m on  d.market_campaign_code=m.code and d.org_id=m.org_id
		where d.code=${fld:ecode} and d.org_id = ${fld:org_id}
		),
		
		(select 
		(
			case 
				when m.enddate is null  then d.enddate --活动空
			else	--活动不空
					(case when d.enddate  is not null then --体验卡不空
							(case when
									m.startdate<d.enddate then m.enddate else d.enddate 
								end)
							else m.enddate
						end)
			end)
		from cc_expercard d 
		left join cc_market_campaign m on  d.market_campaign_code=m.code and d.org_id=m.org_id
		where d.code=${fld:ecode} and d.org_id = ${fld:org_id}
		),
	'${def:user}',
	1,
	{ts '${def:timestamp}'},
	${fld:org_id}
	)