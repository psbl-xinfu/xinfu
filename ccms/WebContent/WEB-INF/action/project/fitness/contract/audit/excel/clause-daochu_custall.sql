and 
	(
		c.code = ${fld:daochu_custall}
		or
		m.name like concat('%', ${fld:daochu_custall}, '%')
		or
		m.mobile like concat('%', ${fld:daochu_custall}, '%')
		or
		m.code like concat('%', ${fld:daochu_custall}, '%')
	)
