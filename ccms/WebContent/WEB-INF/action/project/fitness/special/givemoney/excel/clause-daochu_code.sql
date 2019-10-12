and
	(cust.name like concat('%', ${fld:daochu_code}, '%') 
		or cust.code like concat('%', ${fld:daochu_code}, '%')
		or cust.mobile like concat('%', ${fld:daochu_code}, '%')
		or
			exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = cust.code 
				and card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_code} and org_id = ${def:org})
			)
	)