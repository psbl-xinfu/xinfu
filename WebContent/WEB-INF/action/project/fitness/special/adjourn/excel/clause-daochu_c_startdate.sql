and
	(case when ${fld:daochu_code} is null then p.createdate::date >= ${fld:daochu_c_startdate} else 1=1 end)