SELECT 
	DISTINCT 
	d.code AS vc_cardcode
	,d.customercode
	,d.cardtype
	,dt.name AS vc_cardtypename
	,d.status
	,CASE d.status WHEN 0 THEN '无效' WHEN 1 THEN '正常' WHEN 2 THEN '未启用' WHEN 3 THEN '存卡中' 
		WHEN 4 THEN '挂失中' WHEN 5 THEN '停卡中' WHEN 6 THEN '过期' END AS i_statusname
FROM cc_card d 
LEFT JOIN cc_cardtype dt ON d.cardtype = dt.code and d.org_id = dt.org_id
WHERE d.customercode = ${fld:vc_code} and d.org_id = ${def:org}
