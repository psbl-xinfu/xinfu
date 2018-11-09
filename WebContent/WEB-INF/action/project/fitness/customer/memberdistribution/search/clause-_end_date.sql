 AND 
	(case when ${fld:vc_all} is null then r.indate::date <= ${fld:_end_date}::date else 1=1 end)
