and
	(c.code like concat('%', ${fld:daochu_relatecode}, '%') 
	or c.relatecode like concat('%', ${fld:daochu_relatecode}, '%')
	)
 
