-- add by leo 190527微信退出时需取微信配置，初始化登陆地址
select 
tuid,
appid,
access_address
from  
wx_service
-- add by leo 190523 更具当前用户绑定获取微信wx_service 表tuid等相关信息
where tuid=(select 
staff.weixin_service_id
from 
hr_staff staff
WHERE staff.userlogin ='${def:user}') 
limit 1
