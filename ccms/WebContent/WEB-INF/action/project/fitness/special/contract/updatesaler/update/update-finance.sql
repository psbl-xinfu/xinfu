UPDATE cc_finance 
SET 
	salesman = ${fld:vc_salemember} 
WHERE operationcode = ${fld:vc_contractcode} and org_id = ${def:org}
