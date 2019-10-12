WITH timerange AS (
	SELECT 
		to_char({ts '${def:timestamp}'},'yyyy-01-01')::date AS fdate,
		to_char(({ts '${def:timestamp}'} + '1 year'),'yyyy-01-01')::date AS tdate
) 
SELECT 
	month,
	SUM(fee) AS fee 
FROM (
	SELECT 
		t.createdate,
		to_char(t.createdate, 'MM')::integer AS month,
		(CASE WHEN t.salemember1 IS NOT NULL AND t.salemember1 != '' THEN t.factmoney/2.00 ELSE t.factmoney END) AS fee
	FROM cc_contract t 
	WHERE t.salemember = '${def:user}' 
	AND t.createdate >= (SELECT fdate FROM timerange) 
	AND t.createdate < (SELECT tdate FROM timerange) 
	AND t.type IN (0,5,7,9,11,2) AND t.status >= 2 
	
	UNION 
	
	SELECT 
		t.createdate,
		to_char(t.createdate, 'MM')::integer AS month,
		(t.factmoney/2.00) AS fee
	FROM cc_contract t 
	WHERE t.salemember1 = '${def:user}' 
	AND t.createdate >= (SELECT fdate FROM timerange) 
	AND t.createdate < (SELECT tdate FROM timerange) 
	AND t.type IN (0,5,7,9,11,2) AND t.status >= 2 
) tp 
GROUP BY month 
ORDER BY month
