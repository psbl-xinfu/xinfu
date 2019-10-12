select 
	s.code,
	s.cardcode,
	s.customercode,
	cust.name as cust_name,
	cust.mobile,
	card.startdate,
	card.enddate,
	(select name from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardtype,
	s.startdate as stopstartdate,
	s.prestopdays,
	s.money,
	s.remark,
	card.nowcount,
	s.reason
from cc_savestopcard s
left join cc_card card on card.code = s.cardcode and s.org_id = card.org_id and card.isgoon=0
left join cc_customer cust on cust.code = s.customercode and cust.org_id = s.org_id
where s.code = ${fld:code} and s.org_id = ${def:org}
