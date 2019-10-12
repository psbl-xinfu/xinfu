AND (goods_name like concat('%', ${fld:daochu_gname}, '%') 
		or fastcode like concat('%', ${fld:daochu_gname}, '%'))
