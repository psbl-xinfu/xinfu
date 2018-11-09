SELECT DISTINCT c.code
	   ,c.name 
FROM cc_customer c 
WHERE c.code=${fld:customercode} and c.status=1 and c.org_id=${def:org}