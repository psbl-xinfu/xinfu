SELECT COUNT(1) AS total 
FROM (
	/** 当前合同是普通合同、分期付款第一期主合同 */
	SELECT 1 
	FROM cc_contract 
	WHERE relatecode = ${fld:vc_code} AND status > 0  and org_id = ${def:org}
	
	UNION ALL 
	
	/** 当前合同是分期付款第一期之后合同 */
	SELECT 1 
	FROM cc_contract t1 
	WHERE EXISTS(
		SELECT 1 FROM cc_contract t2 WHERE t2.code = ${fld:vc_code} 
		AND t1.code = t2.relatecode 
		AND t2.stage_times_pay > t1.stage_times_pay
		  and org_id = ${def:org}
	) AND status > 0  and org_id = ${def:org}
) AS k
