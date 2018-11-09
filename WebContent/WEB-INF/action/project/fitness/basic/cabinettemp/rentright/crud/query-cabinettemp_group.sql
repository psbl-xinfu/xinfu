 select
 	tuid,
 	groupname,
 	groupcode
 from
 	cc_cabinettemp_group
 where
 	status=1
 	and org_id=${def:org}



