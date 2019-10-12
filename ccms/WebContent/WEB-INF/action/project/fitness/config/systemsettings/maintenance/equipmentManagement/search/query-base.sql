select 
	code as cnfg_id,
	deviceid,
	appid,
	(case when type::int=1 then '指静脉' 
	when type::int=2 then '二维码'
	when type::int=3 then '刷卡'
	when type::int=4 then '人脸'
	end) as type,
	(case when
	status=0 then '可用'
	when status=1 then '禁用'
	end) as status,
	remark
from cc_device
where org_id=${def:org}