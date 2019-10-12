and 
	
	(
	c.code like concat('%', ${fld:pickcustname}, '%')
	or
	c.code in (select cardcode from cc_cardcode where incode = ${fld:pickcustname} and org_id = ${def:org})
	)
