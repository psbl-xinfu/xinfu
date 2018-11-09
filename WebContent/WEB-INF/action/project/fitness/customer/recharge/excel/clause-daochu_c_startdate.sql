and
	(case when ${fld:daochu_cust} is null 
		then c.created::date>= ${fld:daochu_c_startdate} and c.created::date <= ${fld:daochu_c_enddate} 
		else 1=1 end)
