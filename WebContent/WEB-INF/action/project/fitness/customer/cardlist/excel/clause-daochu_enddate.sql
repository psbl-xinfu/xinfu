and
	(case when ${fld:daochu_cardall} is null 
		then card.startdate::date<=${fld:daochu_enddate} 
		else 1=1 end)
