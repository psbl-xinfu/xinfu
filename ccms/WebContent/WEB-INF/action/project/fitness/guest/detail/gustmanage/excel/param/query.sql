select 
	case when ${fld:vc_name} is not null and ${fld:vc_name} != '' then ascii(${fld:vc_name}) else null end as vc_name,
	case when ${fld:vc_level} is not null and ${fld:vc_level} != '' then ascii(${fld:vc_level}) else null end as vc_level 
from dual