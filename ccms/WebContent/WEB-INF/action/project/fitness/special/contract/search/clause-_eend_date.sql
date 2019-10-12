 AND 
	(case when ${fld:vc_all} is null then c.createdate::date between ${fld:_start_date} and ${fld:_eend_date} else 1=1 end)