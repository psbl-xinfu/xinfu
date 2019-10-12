 select
 	g.groupname,
 	b.cabinetcode as gid,
	b.status,
	b.physics_status
 	from
 	cc_cabinet b
 	left join cc_cabinet_group g on g.tuid=b.groupid 
where 
	b.tuid = ${fld:id}
and b.org_id=${def:org}
