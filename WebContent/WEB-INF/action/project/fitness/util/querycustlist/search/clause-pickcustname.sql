and (
	c.code like concat('%', ${fld:pickcustname}, '%') or
	c.mobile like concat('%', ${fld:pickcustname}, '%') or c.name like concat('%', ${fld:pickcustname}, '%') 
	or exists(
		select 1 from cc_card d 
		where d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 and d.status != 0
		and (d.code like concat('%', ${fld:pickcustname}, '%') 
		or d.code in (select cardcode from cc_cardcode where incode = ${fld:pickcustname} and org_id = ${def:org}))
	)
) 