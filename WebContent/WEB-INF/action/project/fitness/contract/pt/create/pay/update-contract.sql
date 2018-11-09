UPDATE cc_contract 
SET 
	status = 2
	,collectby = '${def:user}'
	,collectdate = '${def:date}'
	,collecttime = '${def:time}'
	,billcode = currval('seq_cc_finance')::varchar
	,factmoney = ${fld:factmoney} 
	,pay_detail = ${fld:paydetail} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
