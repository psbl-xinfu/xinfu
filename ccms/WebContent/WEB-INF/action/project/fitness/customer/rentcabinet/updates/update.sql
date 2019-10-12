update  cc_cabinet
set status = 0
where cabinetcode::varchar = (select cabinetcode from cc_cabinet_rent 
	where tuid = ${fld:id}::int and org_id = ${def:org})
and org_id = ${def:org}
