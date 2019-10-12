select 
	code as cnfg_id,
	deviceid,
	appid,
	type,
	status,
	remark
from cc_device
where code=${fld:id} and org_id=${def:org}