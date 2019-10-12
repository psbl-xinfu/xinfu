select 
	tuid,
	groupname,
	remark
from et_group
where tuid = ${fld:id}
