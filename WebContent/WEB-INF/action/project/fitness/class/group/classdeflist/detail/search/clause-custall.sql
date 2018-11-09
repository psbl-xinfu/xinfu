 AND (cust.name like concat('%', ${fld:custall}, '%') 
 	or cust.mobile like concat('%', ${fld:custall}, '%')
 	or cp.phone like concat('%', ${fld:custall}, '%')) 
