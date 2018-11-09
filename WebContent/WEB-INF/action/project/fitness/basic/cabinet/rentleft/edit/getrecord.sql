select	
    groupname,
	groupcode
from
cc_cabinet_group
where 
	tuid = ${fld:id}
