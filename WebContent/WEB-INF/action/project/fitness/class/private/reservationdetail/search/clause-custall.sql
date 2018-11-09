 AND 
 	(c.name like concat('%', ${fld:custall}, '%')  
 		or c.mobile = ${fld:custall} 
 		or
			exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = c.code 
				and (card.code = ${fld:custall} or card.code in (select cardcode from cc_cardcode where incode = ${fld:custall} and org_id = ${def:org}))
			)
	)
