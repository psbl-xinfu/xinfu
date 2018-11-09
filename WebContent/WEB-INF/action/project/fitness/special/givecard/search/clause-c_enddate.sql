and
	(case when ${fld:cust} is null then op.createdate::date <= ${fld:c_enddate} else 1=1 end)
