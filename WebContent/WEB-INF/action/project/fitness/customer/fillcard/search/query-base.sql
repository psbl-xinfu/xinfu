select 
	concat('<input type="radio" name="fillcard" value="' , f.code , '" code2="', f.status, '" />') AS radio_link ,
	f.code,
	f.cardcode,
	(select name from cc_cardtype where code = card.cardtype and org_id = ${def:org}) as cardtype,
	cust.name as cust_name,
	f.oldcardcode,
	f.money,
	f.remark,
	f.created,
	(case when f.status=1 then '已补卡' when f.status=10 then '未付款' end) as status,
	(select name from hr_staff where userlogin = f.createdby) as createdby
from cc_fillcard f
left join cc_customer cust on f.customercode = cust.code and f.org_id = cust.org_id
left join cc_card card on f.oldcardcode = card.code and card.org_id = f.org_id  and card.isgoon!='-1'
where f.org_id = ${def:org} and f.status !=0
${filter}
${orderby}
