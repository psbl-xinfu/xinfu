 AND 
	(case when ${fld:daochu_vc_all} is null then r.indate::date <= ${fld:daochu_end_date}::date else 1=1 end)
