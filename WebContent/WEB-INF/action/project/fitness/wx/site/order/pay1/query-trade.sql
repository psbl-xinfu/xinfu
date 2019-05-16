SELECT 
	'福康云订单'::character varying AS out_trade_name
	,t1.total_price AS out_trade_price
	,s.detail
	,s.phone
	,t1.tuid AS sale_order_code 
	,d1.domain_text_cn AS province
	,d2.domain_text_cn AS city
	,d3.domain_text_cn AS country
	
	,t1.total_price
	,t2.name
	,t2.mobile
	,t1.trade_order_code,
	CASE WHEN '${def:httpserver}' LIKE '%:80' THEN substr('${def:httpserver}', 0, length('${def:httpserver}')-2) 
		WHEN '${def:httpserver}' LIKE '%:80/' THEN substr('${def:httpserver}', 0, length('${def:httpserver}')-3) 
		ELSE '${def:httpserver}' END AS server_path 
FROM ws_trade_order t1 
JOIN ws_sale_order s ON s.trade_order_id = t1.tuid 
JOIN hr_staff t2 ON t1.createdby = t2.userlogin 
LEFT JOIN t_domain d1 ON d1.namespace = 'Province' AND d1.domain_value = s.province 
LEFT JOIN t_domain d2 ON d2.namespace = 'City' AND d2.domain_value = s.city 
LEFT JOIN t_domain d3 ON d3.namespace = 'Region' AND d3.domain_value = s.country 
WHERE t1.tuid = ${fld:out_trade_no}
