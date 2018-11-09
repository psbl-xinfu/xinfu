and--保护期
	(${fld:s_period_day}::int-('${def:date}'::date -
		(case when 
			(select   created 
				 from cc_mcchange 
			where customercode =c.code and org_id = ${def:org} order by created desc limit 1)is null then '${def:date}'::date
		else 
		(select   created 
				 from cc_mcchange 
		where customercode = c.code and org_id = ${def:org} order by created desc limit 1)
		end)
::date))<=${fld:s_baohuqi}::int 