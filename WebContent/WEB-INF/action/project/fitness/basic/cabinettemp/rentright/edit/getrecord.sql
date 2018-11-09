 select
 	g.groupname,
 	b.cabinettempcode as gid,
	b.status,
	b.physics_status
 	from
 	cc_cabinettemp b
 	left join cc_cabinettemp_group g on g.tuid=b.groupid 
where 
	b.tuid = ${fld:id}
and b.org_id=${def:org}
