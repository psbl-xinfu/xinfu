select 
	code as cnfg_id,
	appid,
	remark
from cc_atube
where code=${fld:id} and org_id=${def:org}