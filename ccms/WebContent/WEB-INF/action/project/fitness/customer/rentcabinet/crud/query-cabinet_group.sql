 select
 	tuid,
 	groupname,
 	groupcode
 from
 	cc_cabinet_group
 where
 	status=1
 	and org_id=${def:org}



