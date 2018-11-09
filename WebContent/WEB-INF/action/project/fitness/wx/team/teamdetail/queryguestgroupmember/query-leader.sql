select 
	gg.leader
from cc_guest_group gg
where gg.org_id = ${fld:org_id}
and tuid = ${fld:groupid}

