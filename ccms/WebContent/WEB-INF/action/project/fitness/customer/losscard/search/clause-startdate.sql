and
	(case when ${fld:cust} is null then lc.startdate::date >= ${fld:startdate} else 1=1 end)
