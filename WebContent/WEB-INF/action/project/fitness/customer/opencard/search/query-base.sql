select
	concat('<input type="radio" name="opencard" value="', card.code, '" code="1" />') AS checklink,
	card.code as cardcode,
	cust.name,
	cust.mobile,
	null as old_startdate,
	null as old_enddate,
	card.startdate,
	card.enddate,
	'未开卡' as opentype,
	ct.name as cardtypename
from cc_card card
left join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
inner join t_domain dm on card.starttype::varchar = dm.domain_value
where card.status=2 and card.isgoon =0 	--未启用，不是续卡
and card.org_id = ${def:org} and card.starttype = 2	--固定时间启用 
and (case when ${fld:opentype} is null then 1=1 else 
		(case when ${fld:opentype}='1' then 1=1 else 1=2 end) end)
and (card.relatecode is null or card.relatecode='')
${filter}

union

select 
	concat('<input type="radio" name="opencard" value="', oc.cardcode, '" code="2" />') AS checklink,
	oc.cardcode,
	cust.name,
	cust.mobile,
	oc.old_startdate,
	oc.old_enddate,
	oc.startdate,
	oc.enddate,
	'已开卡' as opentype,
	ct.name as cardtypename
from cc_opencard oc
left join cc_card card on oc.cardcode = card.code and oc.org_id = card.org_id
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
left join cc_customer cust on oc.customercode = cust.code and oc.org_id = cust.org_id
where oc.org_id = ${def:org} and oc.status=1 and card.isgoon =0 	--未启用，不是续卡
and (case when ${fld:opentype} is null then 1=1 else 
		(case when ${fld:opentype}='1' then 1=2 else 1=1 end) end)
${filter}
		
order by startdate desc