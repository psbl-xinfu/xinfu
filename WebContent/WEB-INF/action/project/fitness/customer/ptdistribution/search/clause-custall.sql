and 
(
	c.name LIKE concat('%', ${fld:custall}, '%') 
	or c.mobile LIKE concat('%', ${fld:custall}, '%') 
 	or c.code LIKE concat('%', ${fld:custall}, '%') 
 	or exists(
 		select 1 from cc_card cd where cd.customercode = c.code and cd.org_id = c.org_id
 		and cd.isgoon = 0 and cd.status!=0 and (cd.code=${fld:custall} 
 		or cd.code in (select cardcode from cc_cardcode where incode = ${fld:custall} and org_id = ${def:org}))
 	)
)
