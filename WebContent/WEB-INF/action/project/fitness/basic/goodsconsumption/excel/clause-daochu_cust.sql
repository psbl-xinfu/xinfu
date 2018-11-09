AND (cust.name like concat('%', ${fld:daochu_cust}, '%') or 
	cust.mobile like concat('%', ${fld:daochu_cust}, '%') or 
	card.code like concat('%', ${fld:daochu_cust}, '%')
	or  
	card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_cust} and org_id = ${def:org})
	)
