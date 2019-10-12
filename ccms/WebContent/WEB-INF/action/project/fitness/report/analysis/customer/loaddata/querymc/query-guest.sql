SELECT 
	COUNT(1) AS guestnum
FROM cc_guest g 
WHERE g.status != 0 AND g.status != 99 AND g.org_id = ${def:org} 
