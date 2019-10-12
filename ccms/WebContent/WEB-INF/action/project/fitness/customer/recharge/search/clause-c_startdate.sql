and
	(case when ${fld:cust} is null 
		then c.created::date>= ${fld:c_startdate} and c.created::date <= ${fld:c_enddate} 
		else 1=1 end)
