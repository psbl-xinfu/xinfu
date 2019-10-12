select 
	code as cnfg_id,
	appid,
	remark
from cc_atube
where org_id=${def:org}