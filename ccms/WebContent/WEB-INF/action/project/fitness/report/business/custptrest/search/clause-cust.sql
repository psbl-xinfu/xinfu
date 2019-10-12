 AND 
 (cust.name like concat('%', ${fld:cust}, '%') or cust.code like concat('%', ${fld:cust}, '%') 
 or cust.mobile like concat('%', ${fld:cust}, '%'))