UPDATE cc_finance 
SET 
	money = ${fld:f_factmoney}
	,pay_detail = ${fld:pay_detail}
	,remark = ${fld:vc_remark}
	,moneyleft = (${fld:f_normalmoney}-${fld:f_factmoney})
	,created = '${def:date}'
WHERE operationcode = ${fld:vc_contractcode} and org_id =${def:org}
