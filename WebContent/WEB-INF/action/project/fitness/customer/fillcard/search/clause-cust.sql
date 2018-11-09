and
	(cust.name like concat('%', ${fld:cust}, '%') 
		or cust.mobile like concat('%', ${fld:cust}, '%') 
		or f.cardcode like concat('%', ${fld:cust}, '%')
		or  
		f.cardcode in (select cardcode from cc_cardcode where incode = ${fld:cust} and org_id = ${def:org})
		)
