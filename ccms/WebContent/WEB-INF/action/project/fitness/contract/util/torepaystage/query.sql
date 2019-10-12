SELECT 
	code
	,customercode
	,status
	,contracttype
	,type
	,COALESCE(stage_times,1) AS stage_times
	,normalmoney
	,factmoney 
	,(
		t1.factmoney + COALESCE ((
			SELECT SUM (t2.factmoney) FROM cc_contract t2 
			WHERE t2.relatecode = t1.code AND t2.status >= 2 and t2.org_id = t1.org_id
		),0.00) 
	) AS leftmoney
	,COALESCE((
		SELECT t2.status FROM cc_contract t2 
		WHERE t2.relatecode = t1.code AND t2.contracttype = 3 AND t2.status > 0 
		AND to_char(t2.createdate + concat(t2.stage_times_pay-1, ' month')::interval, 'yyyy-MM') = ${fld:month_date} 
		AND t2.org_id = t1.org_id 
	),0) AS repaystatus
FROM cc_contract t1 
WHERE code = ${fld:contractcode} 
AND status > 0 AND stage_times > 1 AND org_id = ${def:org} 
AND (relatecode IS NULL OR relatecode = '') 
AND t1.normalmoney > t1.factmoney + COALESCE (
	(
		SELECT SUM (t2.factmoney) FROM cc_contract t2 
		WHERE t2.relatecode = t1.code AND t2.status >= 2 and t2.org_id = t1.org_id
	),
	0.00
) 
