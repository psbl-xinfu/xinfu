and
	('${def:date}'::date -(select created from cc_comm 
		where customercode = c.code and org_id = ${def:org} and cust_type=2 order by created desc limit 1)::date)<=${fld:not_comeday}

