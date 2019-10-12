and
	(${fld:s_period_day}::int-('${def:date}'::date -(select created from cc_ptchange 
	where customercode = c.code and org_id = ${def:org} order by created desc limit 1)::date))<${fld:s_baohuqi}::int
