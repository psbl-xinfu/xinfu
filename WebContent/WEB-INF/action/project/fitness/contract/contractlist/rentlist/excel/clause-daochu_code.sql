 and 
	get_arr_value(c.relatedetail,1) =
	(select tuid::varchar from cc_cabinet where cabinetcode = ${fld:daochu_code} and org_id = ${def:org})