select 
	count(1) as dayguestnum
from cc_guest
where created::date = ${fld:daydateinfo}::date
and org_id = ${def:org} and status = 1
and createdby = '${def:user}'