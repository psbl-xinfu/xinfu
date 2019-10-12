UPDATE cc_contract 
SET 
	collectby = '${def:user}'
	,collecttime = '${def:time}'
	,collectdate = ${fld:c_adate}::date 
	,pay_detail = ${fld:pay_detail}
	,remark = ${fld:vc_remark} 
	,factmoney = ${fld:f_factmoney}
	,discounttype = ${fld:i_discounttype}
WHERE code = ${fld:vc_contractcode} and org_id = ${def:org}
