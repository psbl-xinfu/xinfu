and
	(case when ${fld:cust} is null 
		then f.created::date between ${fld:startdate} and ${fld:enddate} else 1=1 end)
