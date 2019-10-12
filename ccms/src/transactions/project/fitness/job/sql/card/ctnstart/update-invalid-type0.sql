-- 时效卡过期的，续卡走该逻辑 zzn 其实也不用改status的状态
UPDATE cc_card d 
SET 	
	status = 6 
FROM cc_cardtype t 
WHERE d.isgoon = 0 AND d.status = 1 
AND d.cardtype = t.code /**AND d.org_id = t.org_id*/ 
AND (t.type = 0 AND d.enddate < '${def:date}'::date) 
AND EXISTS(
	SELECT 1 FROM cc_card d2 WHERE d2.code = d.code 
	AND d2.org_id = d.org_id AND d2.isgoon != 0
)
