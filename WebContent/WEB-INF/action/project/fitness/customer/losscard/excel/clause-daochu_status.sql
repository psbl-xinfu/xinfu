and
	(case
		when ${fld:daochu_status}='1' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=0 and lc.status=1
		when ${fld:daochu_status}='2' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=1
		when ${fld:daochu_status}='3' then 
		(select count(1) from cc_fillcard where cardcode = lc.cardcode and org_id = ${def:org}
		and created>lc.startdate)=0 and lc.status=2
	end)

	