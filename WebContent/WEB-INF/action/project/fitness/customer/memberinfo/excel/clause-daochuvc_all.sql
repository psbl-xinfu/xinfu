AND 
 	(
 		cust.name LIKE concat('%', ${fld:daochuvc_all}, '%')
 	or 
 		cust.mobile LIKE concat('%', ${fld:daochuvc_all}, '%')
 	or
 		exists(
			select 1 from cc_card card
			where card.isgoon=0 and card.org_id = ${def:org}
			and card.customercode = cust.code and card.status != 0 
			and (card.code = ${fld:daochuvc_all} 
			or card.code in (select cardcode from cc_cardcode where incode = ${fld:daochuvc_all} and org_id = ${def:org}))
		)
 	)
 
 
 
  


 
  
