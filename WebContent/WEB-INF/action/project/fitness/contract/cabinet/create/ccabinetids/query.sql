select 
	tuid as tuids,
	cabinetcode as cabinetcodes,
	COALESCE(price,0.00) as prices  
from cc_cabinet 
where tuid = ${fld:ccabinetid} and org_id = ${def:org} 
and physics_status = 1 and status = 0 

