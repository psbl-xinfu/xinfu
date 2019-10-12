AND 
	(case when ${fld:daochu_custall} is null 
		then p.preparedate >= ${fld:daochu_date}::date and p.preparedate <= ${fld:daochu_end_date}::date
		else 1=1 end)
