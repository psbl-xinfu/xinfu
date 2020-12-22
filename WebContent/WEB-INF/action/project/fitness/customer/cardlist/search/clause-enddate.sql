and (case ${fld:status} when '2' then 1=1 else
	(case when ${fld:cardall} is null then card.startdate::date<=${fld:enddate} else 1=1 end)
end)
