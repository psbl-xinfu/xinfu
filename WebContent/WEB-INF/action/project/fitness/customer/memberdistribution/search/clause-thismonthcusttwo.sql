and exists(
		select 1 from cc_mcchange 
		where 
		to_char(created, 'yyyy-MM') = to_char((select current_date), 'yyyy-MM')
		and org_id = ${def:org}
		and r.code = customercode
	)