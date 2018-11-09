select
	cust.code as custcode,
	cust.name as custname,
	card.code as cardcode,
	cust.mobile,
	ls.factmoney,
	ls.normalmoney,
	(select name from hr_staff where userlogin = ls.createdby) as createdby,
	ls.created,
	cust.moneycash,
	cust.moneygift
from cc_leave_stock ls
left join cc_customer cust on ls.customercode = cust.code and ls.org_id = ${def:org}
left join cc_card card on ls.paycardcode = card.code and card.isgoon = 0
where
	ls.tuid=${fld:tuid} and ls.org_id = ${def:org}
