SELECT 
	p.code,
	p.guestcode,
	(CASE WHEN g.name IS NOT NULL AND g.name != '' THEN g.name ELSE '未知' END) AS name,
	(
		CASE WHEN p.contactphone IS NOT NULL AND p.contactphone != '' THEN p.contactphone 
		ELSE (
			CASE WHEN g.mobile IS NOT NULL AND g.mobile != '' THEN g.mobile ELSE '无' END
		) END
	) AS contactphone,
	p.preparedate,
	p.preparetime,
	p.remark 
FROM cc_guest_prepare p 
INNER JOIN cc_guest g ON g.code = p.guestcode AND g.org_id = p.org_id 
WHERE p.preparedate = {d '${def:date}'} AND p.createdby = '${def:user}' AND p.org_id = ${def:org} 
AND p.status != 0 AND p.status != 5 
ORDER BY p.preparetime
