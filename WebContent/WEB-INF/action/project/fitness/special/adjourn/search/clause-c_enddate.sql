and
	(case when ${fld:code} is null then p.createdate::date <= ${fld:c_enddate} else 1=1 end)
