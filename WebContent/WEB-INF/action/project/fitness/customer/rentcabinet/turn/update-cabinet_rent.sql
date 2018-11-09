update cc_cabinet_rent
set enddate =  {ts'${def:timestamp}'},
	is_deleted = 1,
	status = 0
where tuid = ${fld:cabinetrentid}::int
and org_id = ${def:org}
