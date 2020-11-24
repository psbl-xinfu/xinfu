 AND 
	(
	
				 (cu.name like concat('%', ${fld:cust},'%')) 
		or
		
				(cu.mobile like concat('%', ${fld:cust},'%'))
	)
	
