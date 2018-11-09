and (
	c.code like concat('%', ${fld:pickcustname}, '%') or
	c.mobile like concat('%', ${fld:pickcustname}, '%') or c.name like concat('%', ${fld:pickcustname}, '%') 
)