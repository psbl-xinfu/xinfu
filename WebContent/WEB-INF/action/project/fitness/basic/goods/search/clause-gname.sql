AND (goods_name like concat('%', ${fld:gname}, '%') 
		or fastcode like concat('%', ${fld:gname}, '%'))
