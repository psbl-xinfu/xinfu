SELECT 
	code
	,customercode
	,status
	,contracttype
	,type
	,COALESCE(stage_times,1) AS stage_times
	,normalmoney
	,factmoney 
	,COALESCE((
		SELECT t2.status FROM cc_contract t2 
		WHERE t2.relatecode = t1.code AND t2.contracttype = 3 AND t2.status > 0 AND t2.org_id = t1.org_id 
		order by t2.createdate desc,t2.createtime desc limit 1
	),0) AS repaystatus 
FROM cc_contract t1 
WHERE code = ${fld:contractcode} AND t1.stage_times <= 1 
AND status > 0 AND org_id = ${def:org} 
