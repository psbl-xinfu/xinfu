and
	(case when ${fld:daochu_cust_all} is null then enddate::date >= ${fld:daochu_start_date} else 1=1 end)
