SELECT 1 FROM dual
where not exists(
	select 1 from cc_cabinettemp
	WHERE cabinettempcode = ${fld:newcabinettempcode}
	and status = 0 and org_id = ${def:org} and physics_status!=0
)
