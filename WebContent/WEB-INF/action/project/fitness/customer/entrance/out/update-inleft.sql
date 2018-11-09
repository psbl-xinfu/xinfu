update cc_inleft set
	lefttime={ts'${def:timestamp}'},--离场时间
	leftuser='${def:user}' --离场操作人
where code=(
	select code
	from cc_inleft 
	where indate = (select current_date) 
	and cardcode = ${fld:cardcode} and org_id = ${def:org}
	order by intime desc LIMIT 1
) and org_id = ${def:org}
