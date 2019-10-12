and
	(
		cust.name like '%'||${fld:daochus_name}||'%'   
		or
		cust.mobile like '%'||${fld:daochus_name}||'%'   
		or
		cust.code like '%'||${fld:daochus_name}||'%' 
		or exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = cust.code 
				and card.code in (select cardcode from cc_cardcode where incode = ${fld:daochus_name} and org_id = ${def:org})
			)
	)

