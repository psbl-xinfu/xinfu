 AND 
	(case when ${fld:s_name} is null 
		then cr.startdate >= ${fld:s_start_date}::date
		else 1=1 end)
