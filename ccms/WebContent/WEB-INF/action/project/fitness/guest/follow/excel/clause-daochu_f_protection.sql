and
	(${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_mcchange 
	where guestcode = g.code order by created desc limit 1)::date))<${fld:daochu_f_protection}::int
