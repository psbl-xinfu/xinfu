and
	(case when ${fld:cardall} is null then card.startdate::date>=${fld:startdate} else 1=1 end)
