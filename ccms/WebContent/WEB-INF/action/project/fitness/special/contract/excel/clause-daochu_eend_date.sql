 AND 
	(case when ${fld:daochu_vc_all} is null then c.createdate::date between ${fld:daochu_start_date} and ${fld:daochu_eend_date} else 1=1 end)