select	
    groupname,
	groupcode
from
cc_cabinettemp_group
where 
	tuid = ${fld:id}
