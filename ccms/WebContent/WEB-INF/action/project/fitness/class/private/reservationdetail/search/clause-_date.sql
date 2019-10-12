AND 
	(case when ${fld:custall} is null 
		then p.preparedate >= ${fld:_date}::date and p.preparedate <= ${fld:end_date}::date
		else 1=1 end)