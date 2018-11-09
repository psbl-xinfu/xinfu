and
	(${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_ptchange 
	where customercode = c.code and org_id = ${def:org} order by created desc limit 1)::date))<${fld:daochu_f_protection}::int
