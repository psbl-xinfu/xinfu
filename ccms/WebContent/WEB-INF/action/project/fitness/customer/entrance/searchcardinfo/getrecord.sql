select
	card.code,
	cust.name,
	cust.code as cust_code,
	cust.mobile,
	card.nowcount,
	cust.moneyleft,
	(select t.tuid from t_attachment_files t where t.pk_value = cust.code and t.table_code = 'cc_customer' and t.org_id= ${fld:unionorgid} order by t.tuid desc limit 1) as imgid,
	(select ct.name from cc_cardtype ct where ct.code = card.cardtype and ct.org_id = ${fld:unionorgid}) as cardtype_name,
	(select type from cc_cardtype ct where ct.code = card.cardtype and ct.org_id = ${fld:unionorgid}) as type,
	(select name from hr_staff where userlogin = cust.mc and org_id = ${fld:unionorgid}) as mc,
	(select name from hr_staff where userlogin = cust.pt and org_id = ${fld:unionorgid}) as pt,
	(select (case when lefttime is null then (select tuid from cc_cabinettemp where tuid::varchar = cc_inleft.cabinettempcode and org_id = ${def:org})::varchar else '' end)
		from cc_inleft where indate = '${def:date}'::date and cardcode = card.code and org_id = ${def:org} order by intime desc LIMIT 1) as cabinettempcode,
	(select sum(factmoney) from cc_leave_stock where customercode = cust.code 
	and isguazhang = 1 and paystatus = 1 and status=2 and org_id = ${def:org}) as factmoney,
	(select sum(normalmoney) from cc_singleitem where status=1 and customercode = cust.code and org_id = ${def:org}) as normalmoney
from cc_card card
left join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
where
	card.org_id = ${fld:unionorgid} and card.code = ${fld:cardcode}
	and card.isgoon = 0
