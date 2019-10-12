and
	(case
		when ${fld:status}='1' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=0 and lc.status=1
		when ${fld:status}='2' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=1
		when ${fld:status}='3' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=0 and lc.status=2
	end)

	