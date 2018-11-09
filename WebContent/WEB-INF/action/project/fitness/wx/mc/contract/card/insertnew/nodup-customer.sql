SELECT 1 FROM cc_customer c 
WHERE EXISTS(
	SELECT 1 FROM cc_guest g 
	WHERE g.code = ${fld:guestcode}
	AND g.mobile = c.mobile AND g.org_id = c.org_id 
) 
AND c.org_id = ${def:org} AND c.status != 0 
