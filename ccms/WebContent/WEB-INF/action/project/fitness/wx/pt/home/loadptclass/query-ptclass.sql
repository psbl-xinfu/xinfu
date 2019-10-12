select 
	(
		select count(1) from cc_ptprepare
		where preparedate = {d '${def:date}'} and ptid = '${def:user}'
		and status != 0 and org_id = ${def:org} 
	) as prepare_num
	,(
		select count(1) from cc_ptlog 
		where created::date = {d '${def:date}'} and ptid = '${def:user}' 
		and status = 1 and org_id = ${def:org} 
	) as pttoday_num
	,(
		select count(1) from cc_ptlog 
		where created::date >= get_monday({ts '${def:timestamp}'})::date 
		and created::date <= get_monday({ts '${def:timestamp}'})::date + interval ' 6 day' 
		and ptid = '${def:user}' and status = 1 and org_id = ${def:org} 
	) as ptweek_num
