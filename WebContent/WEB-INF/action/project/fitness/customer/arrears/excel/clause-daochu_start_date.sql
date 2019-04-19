and
	(case when ${fld:daochu_cust_all} is null then s.created::date >= ${fld:daochu_start_date} else 1=1 end)
