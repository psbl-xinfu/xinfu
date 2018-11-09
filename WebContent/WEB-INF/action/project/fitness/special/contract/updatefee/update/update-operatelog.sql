UPDATE cc_operatelog 
SET 
	factmoney = ${fld:f_factmoney}
	,pay_detail = ${fld:pay_detail}
WHERE pk_value = ${fld:vc_contractcode} and org_id = ${def:org}
