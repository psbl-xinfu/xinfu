and
	(case when ${fld:daochu_cust} is null then lc.startdate::date <= ${fld:daochu_enddate} else 1=1 end)
