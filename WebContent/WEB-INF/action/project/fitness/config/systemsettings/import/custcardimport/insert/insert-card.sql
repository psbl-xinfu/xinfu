INSERT INTO cc_card(
	code
	,isgoon
	,customercode
	,cardtype
	,startdate
	,enddate
	,totalday
	,giveday
	,factmoney
	,count
	,nowcount
	,created
	,createdby
	,remark
	,starttype
	,contractcode
	,status
	,org_id
) 
values
(
	${fld:cardcode},
	0,
	${fld:custcode},
	${fld:cardtype},
	${fld:startdate},
	${fld:enddate},
	(select daycount from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1),
	(select giveday from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1),
	(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),
	(select count from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1),
	(case when ${fld:nowcount}=0 
		then (select count from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1)
		else ${fld:nowcount} end),
	{ts '${def:timestamp}'},
	'${def:user}',
	${fld:remark},
	${fld:starttype},
	${fld:contractcode},
	${fld:status},
	${def:org}
)
