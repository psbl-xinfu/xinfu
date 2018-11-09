 AND 
 	(c.name like concat('%', ${fld:daochu_custall}, '%')  
 		or c.mobile = ${fld:daochu_custall} 
 		or
			exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = c.code 
				and (card.code = ${fld:daochu_custall} 
				or card.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_custall} and org_id = ${def:org}))
			)
	)
