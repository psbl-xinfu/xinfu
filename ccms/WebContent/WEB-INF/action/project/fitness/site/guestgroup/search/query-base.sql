select
	concat('<input type="checkbox" name="groupcheckbox" value="', cg.tuid, '" />') AS checklink,
	cg.groupname
from cc_guest_group cg
where cg.org_id = ${def:org} and cg.status = 1
${filter}
${orderby}
