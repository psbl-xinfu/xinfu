and
	(case when ${fld:cardall} is null then card.startdate::date<=${fld:enddate} else 1=1 end)
