select 1 from cc_cabinet_group g where 
g.tuid = ${fld:groupid} and g.org_id=${def:org} 
and g.groupcode  != ${fld:groupcode}
and
exists(
	select 1 from cc_cabinet b where g.tuid=b.groupid  and b.org_id=${def:org}
) 
