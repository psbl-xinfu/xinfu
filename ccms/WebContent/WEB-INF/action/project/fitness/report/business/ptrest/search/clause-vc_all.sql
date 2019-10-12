 AND 
 (c.name like concat('%', ${fld:vc_all}, '%') or c.code like concat('%', ${fld:vc_all}, '%') 
 or c.mobile like concat('%', ${fld:vc_all}, '%'))