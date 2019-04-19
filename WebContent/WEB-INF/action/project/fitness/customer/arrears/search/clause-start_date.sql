and
	(case when ${fld:cust_all} is null then s.created::date >= ${fld:start_date} else 1=1 end)
