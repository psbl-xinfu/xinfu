 AND 
	 (cust.name like concat('%', ${fld:daochu_cust}, '%') 
	 or cust.code like concat('%', ${fld:daochu_cust}, '%') 
	 or cust.mobile like concat('%', ${fld:daochu_cust}, '%'))