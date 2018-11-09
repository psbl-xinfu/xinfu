update cc_cabinet
set status = 0
where cabinetcode = (select cabinetcode from cc_cabinet_rent 
	where tuid = ${fld:cabinetrentid}::int and org_id = ${def:org}
	)
and org_id = ${def:org}
