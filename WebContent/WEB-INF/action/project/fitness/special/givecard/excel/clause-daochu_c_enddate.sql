and
	(case when ${fld:daochu_cust} is null then op.createdate::date <= ${fld:daochu_c_enddate} else 1=1 end)
