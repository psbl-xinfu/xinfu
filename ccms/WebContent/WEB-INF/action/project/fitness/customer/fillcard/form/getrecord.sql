SELECT
	f.code,
	f.oldcardcode,
	f.cardcode,
	f.customercode,
	cust.name as cust_name,
	cust.mobile,
	cust.moneycash,
	cust.moneygift,
	(case when ct.name is null
	then (select name from cc_cardtype where code = 
		(select cardtype from cc_card where code = f.oldcardcode and org_id = ${def:org})
		and org_id = ${def:org})
	else ct.name
	 end)as cardtype,
	f.cardstartdate,
	f.cardenddate,
	f.incode,
	f.money,
	f.remark,
	card.cardtype as cardtypecode
FROM cc_fillcard f
left join cc_customer cust on f.customercode = cust.code and f.org_id = cust.org_id
left join cc_card card on f.oldcardcode = card.code and f.org_id = card.org_id and card.isgoon=0
left join cc_cardtype ct on ct.code = card.cardtype and ct.org_id = card.org_id 
WHERE f.org_id =${def:org} and f.code = ${fld:code}
