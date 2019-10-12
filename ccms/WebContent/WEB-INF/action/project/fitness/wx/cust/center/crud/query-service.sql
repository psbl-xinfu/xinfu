SELECT 
	tuid,
	appid,
	access_address 
FROM wx_service
-- add by leo 190523 更具当前用户绑定获取微信wx_service 表tuid等相关信息
where tuid=(select 
staff.weixin_service_id
from 
hr_staff staff
WHERE staff.userlogin ='${def:user}') 
ORDER BY tuid LIMIT 1