and
	(c.code like concat('%', ${fld:relatecode}, '%') 
	or c.relatecode like concat('%', ${fld:relatecode}, '%')
	)
 
