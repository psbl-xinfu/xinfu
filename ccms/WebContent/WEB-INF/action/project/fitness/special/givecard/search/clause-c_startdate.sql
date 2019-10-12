and
	(case when ${fld:cust} is null then op.createdate::date >= ${fld:c_startdate} else 1=1 end)