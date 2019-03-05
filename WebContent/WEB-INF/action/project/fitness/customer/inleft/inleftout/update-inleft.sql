update cc_inleft set
	lefttime={ts'${def:timestamp}'},--离场时间
	leftuser='${def:user}' --离场操作人
where code=${fld:inleftcode} and org_id = ${fld:org_id}
