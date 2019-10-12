 and
	(case when ${fld:daochuvc_all} is null then indate::date >= ${fld:daochu_start_date}::date else 1=1 end)