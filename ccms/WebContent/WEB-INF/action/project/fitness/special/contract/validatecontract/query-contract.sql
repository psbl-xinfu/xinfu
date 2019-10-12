SELECT 
	contracttype as contracttype
	,type as i_type
	,CASE WHEN contracttype = 1 OR contracttype = 2 OR type = 6 THEN '升级合同' 
		WHEN contracttype = 3 THEN '还款合同' 
		WHEN type = 5 OR type = 0 THEN '办卡合同' 
		WHEN type = 7 OR type = 9 OR type = 11 THEN '续卡合同' 
		WHEN type = 10 THEN '转卡合同' 
		WHEN type = 12 THEN '租柜合同' 
		WHEN type = 1 THEN '续租柜合同'
		WHEN type = 2 THEN '私教合同'
		WHEN type = 4 THEN '退卡合同' END AS vc_contractttype
	,COALESCE(stage_times,0) AS i_stage_times
	,COALESCE(stage_times_pay,0) AS i_stage_times_pay 
	,(
		CASE WHEN COALESCE(stage_times,0) > 1 THEN (
			CASE WHEN contracttype = 3 AND stage_times_pay = (
				SELECT t2.stage_times_pay FROM 
					cc_contract t2 WHERE org_id = ${def:org} and t.relatecode = t2.code AND t2.stage_times > 1
			) THEN 1 
			WHEN contracttype = 0 AND stage_times_pay = 1 THEN 1 ELSE 0 END
		) ELSE 0 END
	) AS stage_times_pay_last ,
 	get_arr_value(relatedetail, 1) as card_code
FROM cc_contract t 
WHERE code = ${fld:vc_code} and org_id = ${def:org}
