INSERT INTO cc_finance(
	code
	,cardcode
	,customercode
	,operatelogcode
	,operationcode
	,salesman
	,type
	,item
	,ptlevelcode
	,detail
	,premoney
	,money
	,moneyleft
	,remark
	,createdby
	,created
	,status
	,pay_detail
	,org_id
) 
SELECT 
	currval('seq_cc_finance')
	,get_arr_value(t.relatedetail, 1)
	,t.customercode
	,COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')
		||lpad(nextval('seq_cc_operatelog')::varchar, 8, '0')
	,t.code
	,t.salemember	-- salesman
	,1
	,13
	,NULL
	,NULL	-- detail
	,0	-- premoney
	,${fld:factmoney}
	,-${fld:factmoney}
	,t.remark
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,1
	,${fld:paydetail} 
	,t.org_id 
FROM cc_contract t 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org}
