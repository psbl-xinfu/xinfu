and
	(case when ${fld:daochu_cust} is null 
		then f.created::date between ${fld:daochu_startdate} and ${fld:daochu_enddate} else 1=1 end)
