SELECT 
	t.code,--卡类型编码
	COALESCE(f.cardfee,0.00) AS cardfee,--卡费
	t.name,-- 名称
	COALESCE(t.daycount,0) AS daycount,-- 有效天数
	COALESCE(t.giveday,0) AS giveday, -- 额外赠送天数
	COALESCE(t.ptcount,0) AS ptcount,-- 赠送免费课节数
	0::numeric(10,2) as initiation 
FROM cc_cardtype t 
INNER JOIN cc_cardtype_fee f ON t.code = f.cardtype AND t.org_id = f.org_id 
WHERE t.status = 1 AND t.org_id = ${def:org} 