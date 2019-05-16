SELECT 
	t2.tuid AS service_id
	,t2.appid AS app_id
	,t2.appsecret 
FROM wx_service t2
INNER JOIN wx_pay t3 ON t2.pay_id = t3.tuid 
WHERE t2.tenantry_id = ${def:org} AND t2.is_deleted = '0'
