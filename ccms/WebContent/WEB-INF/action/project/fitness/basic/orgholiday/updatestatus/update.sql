update hr_org_holiday set 
	status = ${fld:status}
where
	tuid = ${fld:id} and org_id = ${def:org}
