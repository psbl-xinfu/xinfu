update hr_org_holiday
	set status = 0
where tuid=${fld:id} 
and org_id = ${def:org}
