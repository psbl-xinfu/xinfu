select
	gg.tuid as ggtuid,
	gg.groupname
from cc_guest_group gg
left join cc_guest_group_member cg on gg.tuid = cg.groupid and gg.org_id = cg.org_id
where cg.status = 1 and cg.org_id = ${def:org}
and guesttype = ${fld:customertype} and pkvalue = ${fld:pkvalue}