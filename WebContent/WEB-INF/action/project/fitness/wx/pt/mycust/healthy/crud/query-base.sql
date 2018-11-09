SELECT
	p.code,
	p.cardcode
FROM cc_ptprepare p  
 JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id and  c.code=${fld:customercode}
WHERE 
 p.org_id = ${def:org}
 order by p.created desc limit 1
