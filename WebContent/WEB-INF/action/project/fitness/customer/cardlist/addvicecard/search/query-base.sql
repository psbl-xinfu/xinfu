select 
	cust.name,
	cust.mobile,
	(case when cust.sex = 1 then '男' when cust.sex = 0 then '女' else '未知' end) as sex,
	(SELECT domain_text_cn FROM t_domain WHERE namespace = 'Age' and domain_value = cust.age::varchar) as age,
	(case when cust.cardtype = 0 then '身份证' when cust.cardtype = 1 then '驾驶证' 
		when cust.cardtype = 2 then '其他' else '未知' end) as cardtype,
	cust.card,
	cust.urgent,
	cust.othertel,
	card.code as cardcode,
	cc.incode
from cc_card card
left join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
left join cc_cardcode cc on cc.cardcode = card.code and card.org_id = cc.org_id
where card.relatecode = ${fld:card_code} and card.status != 0 and card.isgoon = 0
and card.org_id = ${def:org}
