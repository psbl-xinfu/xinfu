 and (CASE ${fld:i_contracttype} WHEN 0 THEN (c.type = 0 AND c.contracttype NOT IN (1,2,3)) --办卡合同
		WHEN 1 THEN (c.type = 5 AND c.contracttype NOT IN (1,2,3)) --定金合同
		WHEN 2 THEN (c.contracttype = 3) --还款合同
		WHEN 3 THEN (c.contracttype = 1 OR c.contracttype = 2 OR c.type = 6) --升级合同
		WHEN 4 THEN (c.type = 2 AND c.contracttype NOT IN (1,2,3)) --私教合同
		WHEN 5 THEN (c.type = 4 AND c.contracttype NOT IN (1,2,3)) --退卡合同
		WHEN 6 THEN (c.type IN (7,9,11) AND c.contracttype NOT IN (1,2,3)) --续卡合同
		WHEN 7 THEN (c.type = 10 AND c.contracttype NOT IN (1,2,3)) --转卡合同
		WHEN 8 THEN (c.type IN (1,12) AND c.contracttype NOT IN (1,2,3)) --租柜合同
	END			
 )
