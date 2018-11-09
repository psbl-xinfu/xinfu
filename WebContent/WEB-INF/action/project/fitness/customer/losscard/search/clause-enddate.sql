and
	(case when ${fld:cust} is null then lc.startdate::date <= ${fld:enddate} else 1=1 end)
