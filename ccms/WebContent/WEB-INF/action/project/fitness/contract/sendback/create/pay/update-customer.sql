/** 清除原办卡合同欠款金额 */
UPDATE cc_customer 
SET 
	moneyleft = (COALESCE(moneyleft,0.00) - COALESCE(${fld:oldleftmoney},0.00)) 
WHERE code = (
	SELECT DISTINCT customercode FROM cc_contract 
	WHERE code = ${fld:contractcode} AND org_id = ${def:org} LIMIT 1
) AND org_id = ${def:org} 
AND 0.00 < COALESCE(${fld:oldleftmoney},0.00) 
