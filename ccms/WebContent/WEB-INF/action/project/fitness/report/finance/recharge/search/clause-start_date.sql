--and
--	(case when ${fld:cust_all} is null then cust.enddate::date >= ${fld:start_date} else 1=1 end)

and
	(case when ${fld:cust_all} is null then enddate::date >= ${fld:start_date} else 1=1 end)
