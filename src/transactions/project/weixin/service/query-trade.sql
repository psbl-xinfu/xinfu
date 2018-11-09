SELECT
	t2.appid,
	t3.mchid AS mch_id,
	(SELECT weixin_lastlogin FROM hr_staff sw WHERE sw.userlogin = t1.userlogin LIMIT 1) AS openid,
	notify_url,
	'JSAPI' AS trade_type,
	t3.partner_key AS partnerkey,
	(
		SELECT SUM(sd.price * sd.quantity) 
		FROM ws_trade_order t 
		INNER JOIN ws_sale_order s ON t.tuid = s.trade_order_id 
		INNER JOIN ws_sale_order_detail sd ON sd.sale_order_id = s.sale_order_id 
		WHERE t.tuid = ${out_trade_no}::integer
	) AS total_fee,
	(
		SELECT ARRAY_AGG(g.goods_name) 
		FROM ws_trade_order t
		INNER JOIN ws_sale_order s ON t.tuid = s.trade_order_id 
		INNER JOIN ws_sale_order_detail sd ON sd.sale_order_id = s.sale_order_id 
		INNER JOIN ws_goods g ON sd.goods_id = g.goods_id 
		WHERE t.tuid = ${out_trade_no}::integer
	) AS body,
	(SELECT trade_order_code FROM ws_trade_order WHERE tuid = ${out_trade_no}::integer) AS out_trade_code
FROM hr_staff t1
JOIN wx_service t2 ON t1.weixin_service_id = t2.tuid
JOIN wx_pay t3 ON t2.pay_id = t3.tuid
WHERE t1.userlogin = '${userlogin}'
