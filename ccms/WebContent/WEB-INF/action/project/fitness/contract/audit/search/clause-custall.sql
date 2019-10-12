and 
	(
		c.code = ${fld:custall}
		or
		m.name like concat('%', ${fld:custall}, '%')
		or
		m.mobile like concat('%', ${fld:custall}, '%')
		or
		m.code like concat('%', ${fld:custall}, '%')
	)
