select 
	tuid,
	cabinetcode,
	COALESCE(price,0.00) as price  
from cc_cabinet 
where groupid = ${fld:groupid} and org_id = ${def:org} 
and physics_status = 1 and status = 0 
order by random() limit 1
