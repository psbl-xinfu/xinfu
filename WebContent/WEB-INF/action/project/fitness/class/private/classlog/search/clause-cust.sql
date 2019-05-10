 AND 
	(
	
				 (pts.name like concat('%', ${fld:cust},'%')) 
		or
		
				(pts.mobile like concat('%', ${fld:cust},'%'))
	)
	
