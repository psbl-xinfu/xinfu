and (
	c.code like concat('%', ${fld:pickcustname}, '%') or
	c.mobile like concat('%', ${fld:pickcustname}, '%') or c.name like concat('%', ${fld:pickcustname}, '%') 
	or exists(
		select 1 from cc_card d 
		where d.code like concat('%', ${fld:pickcustname}, '%') 
		and d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 and d.status != 0 and d.status != 6
	)
) 