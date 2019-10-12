UPDATE cc_contract 
SET 
	status = 2
	,collectby = '${def:user}'
	,collectdate = '${def:date}'
	,collecttime = '${def:time}'
	,billcode = currval('seq_cc_finance')::varchar
	,factmoney = ${fld:factmoney} 
	,pay_detail = ${fld:paydetail}
	,customercode = (case when customercode is null 
			then concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) else 
			customercode
			end)
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
