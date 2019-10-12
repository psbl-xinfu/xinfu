update cc_card set
	status=${fld:status},
	startdate = ${fld:startdate},
	enddate = ${fld:enddate},
	starttype = ${fld:starttype},
	stopdays = ${fld:stopdays},
	nowcount=${fld:nowcount},
	remark=${fld:remark}
where
	code = ${fld:cardcode} and org_id = ${def:org}
	and isgoon = 0
