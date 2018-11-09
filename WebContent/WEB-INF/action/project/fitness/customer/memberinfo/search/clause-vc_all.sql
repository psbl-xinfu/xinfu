 AND 
 	(
 		r.name LIKE concat('%', ${fld:vc_all}, '%')
 	or 
 		r.mobile LIKE concat('%', ${fld:vc_all}, '%')
 	or
 		exists(
			select 1 from cc_card card
			where card.isgoon=0 and card.org_id = ${def:org}
			and card.customercode = r.code and card.status != 0 
			and (card.code = ${fld:vc_all} 
			or card.code in (select cardcode from cc_cardcode where incode = ${fld:vc_all} and org_id = ${def:org}))
		)
 	)
 
 
 
  
