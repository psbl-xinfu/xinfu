and
(
	m.name like concat('%', ${fld:s_name}, '%')
	or 
	m.mobile like concat('%', ${fld:s_name}, '%')
	or
	get_arr_value(c.relatedetail,1) = ${fld:s_name}
	or 
	get_arr_value(c.relatedetail,1) in (select cardcode from cc_cardcode where incode = ${fld:s_name} and org_id = ${def:org})
)	
 
