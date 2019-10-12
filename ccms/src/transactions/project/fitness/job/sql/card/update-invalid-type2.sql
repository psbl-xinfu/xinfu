-- 基金卡两种基金加起来小于10或者过期的
UPDATE cc_card d 
SET 	
	status = 6 
FROM cc_cardtype t 
WHERE d.isgoon = 0 AND d.status = 1 
AND d.cardtype = t.code /**AND d.org_id = t.org_id*/ 
AND t.type = 2 AND (
	EXISTS(
		SELECT 1 FROM cc_customer c WHERE c.code = d.customercode AND c.org_id = d.org_id 
		AND 10 > COALESCE(c.moneycash,0.0) + COALESCE(moneygift,0.0)
	) OR d.enddate < '${def:date}'::date
) 
AND NOT EXISTS(
	SELECT 1 FROM cc_card d2 WHERE d2.code = d.code 
	AND d2.org_id = d.org_id AND d2.isgoon != 0
)
