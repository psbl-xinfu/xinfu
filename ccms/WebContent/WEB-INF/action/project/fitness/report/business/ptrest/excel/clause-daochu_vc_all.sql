 AND 
 (c.name like concat('%', ${fld:daochu_vc_all}, '%') or c.code like concat('%', ${fld:daochu_vc_all}, '%') 
 or c.mobile like concat('%', ${fld:daochu_vc_all}, '%'))