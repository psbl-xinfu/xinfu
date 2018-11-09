and
	(cust.name like concat('%', ${fld:daochu_cust}, '%') 
		or cust.mobile like concat('%', ${fld:daochu_cust}, '%') 
		or f.cardcode like concat('%', ${fld:daochu_cust}, '%')
		or  
		f.cardcode in (select cardcode from cc_cardcode where incode = ${fld:daochu_cust} and org_id = ${def:org})
		)