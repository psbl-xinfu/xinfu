and (cust.code like concat('%', ${fld:cust_all}, '%')
	or cust.name like concat('%', ${fld:cust_all}, '%')
	or cust.mobile like concat('%', ${fld:cust_all}, '%')
	)
