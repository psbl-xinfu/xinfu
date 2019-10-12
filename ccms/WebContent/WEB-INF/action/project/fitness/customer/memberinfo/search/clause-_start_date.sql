 and
	(case when ${fld:vc_all} is null then indate::date >= ${fld:_start_date}::date else 1=1 end)