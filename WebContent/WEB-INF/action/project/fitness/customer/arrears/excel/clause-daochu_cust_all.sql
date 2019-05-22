and (cust.code like concat('%', ${fld:daochu_cust_all}, '%')
	or cust.name like concat('%', ${fld:daochu_cust_all}, '%')
	or cust.mobile like concat('%', ${fld:daochu_cust_all}, '%')
	)
