update cc_card set
	status=${fld:status},
	startdate = ${fld:startdate},
	enddate = ${fld:enddate},
	starttype = ${fld:starttype},
	stopdays = ${fld:stopdays}
where
	relatecode = ${fld:cardcode} and org_id = ${def:org}
	and isgoon = 0