and
	(case when ${fld:daochu_cust} is null then op.createdate::date >= ${fld:daochu_c_startdate} else 1=1 end)