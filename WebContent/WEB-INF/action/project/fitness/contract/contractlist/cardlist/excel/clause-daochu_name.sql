and
(
	m.name like concat('%', ${fld:daochu_name}, '%')
	or 
	m.mobile like concat('%', ${fld:daochu_name}, '%')
	or
	get_arr_value(c.relatedetail,1) = ${fld:daochu_name}
	or 
	get_arr_value(c.relatedetail,1) in (select cardcode from cc_cardcode where incode = ${fld:daochu_name} and org_id = ${def:org})
)	
 
