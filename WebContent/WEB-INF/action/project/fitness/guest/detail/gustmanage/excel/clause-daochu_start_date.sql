AND 
	(case when ${fld:daochuvc_name} is null then g.created::date >= ${fld:daochu_start_date}::date else 1=1 end)
