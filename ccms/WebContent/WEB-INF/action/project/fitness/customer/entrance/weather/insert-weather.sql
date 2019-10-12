insert into cc_weather
(
	weather,
	wdate,
	org_id
)
values(
	${fld:weather},
	'${def:date}',
	${def:org}
)