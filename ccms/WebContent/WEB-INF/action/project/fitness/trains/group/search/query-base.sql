select 
	concat('<input type="checkbox" name="grouplist" " value="', tuid, '" "/>') AS checklink,
	groupname,
	remark
from et_group
where status = 1
${filter}
${orderby}
