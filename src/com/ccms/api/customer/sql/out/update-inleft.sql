update cc_inleft set
	lefttime='${def:timestamp}',--离场时间
	leftuser='zyb-0815', --离场操作人
	remark=${fld:remark}
where code=(
	select code
	from cc_inleft 
	where indate = (select current_date) 
	and cardcode = ${fld:cardcode} and org_id = ${fld:org}
	order by intime desc LIMIT 1
) and org_id = ${fld:org}
