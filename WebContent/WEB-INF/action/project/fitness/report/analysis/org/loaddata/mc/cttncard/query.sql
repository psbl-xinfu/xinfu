SELECT 
	t.created::date AS createdate,
	SUM(1) AS num,
	(select count(1) from cc_contract where (type = 7 OR type = 9 OR type = 11) 
		and status = 2 and customercode = t.customercode and org_id = ${def:org}) as num1
FROM cc_comm t 
WHERE t.created::date >= ${fld:fdate} AND t.created::date <= ${fld:tdate} 
AND t.org_id = ${def:org}
AND t.cust_type = 1 AND t.status != 0 and t.operatortype=0
GROUP BY t.created::date,t.customercode
