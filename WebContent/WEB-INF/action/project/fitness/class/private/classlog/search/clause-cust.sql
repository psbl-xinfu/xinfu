 AND 
	(
	
				 (ct.name like concat('%', ${fld:cust},'%')) 
		or
		
				(ct.mobile like concat('%', ${fld:cust},'%'))
	)
	
