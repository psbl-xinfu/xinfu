AND 
	(case when ${fld:vc_name} is null then g.created::date <= ${fld:_end_date}::date else 1=1 end)