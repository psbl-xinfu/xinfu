select
	count(1) as num
from cc_guest 
where mobile = ${fld:mobile} and status = 1
and (case when ${fld:tuid} is null then 1=1 else code!=${fld:tuid} end)
and org_id = ${def:org}