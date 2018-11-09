AND 
	(case when ${fld:daochus_name} is null 
		then cr.startdate <= ${fld:daochus_end_date}::date
		else 1=1 end)