and
	(case when ${fld:cust_all} is null then enddate::date <= ${fld:end_date} else 1=1 end)