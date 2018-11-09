select 
	cg.tuid,
	cg.groupname,
	cg.groupcode 
from cc_cabinet_group cg
where cg.status = 1 and cg.org_id = ${def:org}
and (select count(1) from cc_cabinet cab 
	where cg.tuid = cab.groupid and cab.status=0 and cab.org_id = cg.org_id)>0