 AND 
	(
		get_arr_value(op.relatedetail,0)=${fld:cust}
		or
		get_arr_value(op.relatedetail,1)=${fld:cust}
		or
		get_arr_value(op.relatedetail,0) 
			in (select code from cc_customer where mobile like concat('%', ${fld:cust},'%') 
				or name like concat('%', ${fld:cust},'%') and org_id=${def:org})
		or
		get_arr_value(op.relatedetail,1) 
			in (select code from cc_customer where mobile like concat('%', ${fld:cust},'%') 
				or name like concat('%', ${fld:cust},'%') and org_id=${def:org})
	)
	
