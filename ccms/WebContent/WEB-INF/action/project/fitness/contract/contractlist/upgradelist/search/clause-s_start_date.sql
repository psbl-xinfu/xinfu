AND 
	(case when ${fld:s_name} is null then createdate >= ${fld:s_start_date} else 1=1 end)