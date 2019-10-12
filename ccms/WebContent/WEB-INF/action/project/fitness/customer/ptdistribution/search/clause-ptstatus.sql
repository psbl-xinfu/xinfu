/**	1未预约、2已预约、3免费I、4免费II	*/ 
AND (CASE ${fld:ptstatus} WHEN '1' THEN NOT EXISTS (
		SELECT 1 FROM cc_ptprepare p 
		WHERE p.customercode = c.code
		AND p.status = 1 and p.org_id = c.org_id
	) 
	WHEN '2' THEN EXISTS (
		SELECT 1 FROM cc_ptprepare p 
		WHERE p.customercode = c.code 
		AND p.status = 1  and p.org_id = c.org_id
	) 
	WHEN '3' THEN 1 = (
		SELECT COUNT(1) FROM cc_ptlog g 
		INNER JOIN cc_ptrest r ON g.ptrestcode = r.code  and g.org_id = r.org_id
		WHERE g.customercode = c.code 
		AND r.pttype = 5 and g.org_id = c.org_id
	) 
	WHEN '4' THEN 2 <= (
		SELECT COUNT(1) FROM cc_ptlog g 
		INNER JOIN cc_ptrest r ON g.ptrestcode = r.code and g.org_id = r.org_id
		WHERE g.customercode = c.code  
		AND r.pttype = 5 and g.org_id = c.org_id
	) 
	ELSE TRUE END
)
