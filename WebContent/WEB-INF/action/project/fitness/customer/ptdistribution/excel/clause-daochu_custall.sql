and 
(
	c.name LIKE concat('%', ${fld:daochu_custall}, '%') 
	or c.mobile LIKE concat('%', ${fld:daochu_custall}, '%') 
 	or c.code LIKE concat('%', ${fld:daochu_custall}, '%') 
 	or exists(
 		select 1 from cc_card cd where cd.customercode = c.code and cd.org_id = c.org_id
 		and cd.isgoon = 0 and cd.status!=0 and (cd.code=${fld:daochu_custall} 
 		or cd.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_custall} and org_id = ${def:org}))
 	)
)
