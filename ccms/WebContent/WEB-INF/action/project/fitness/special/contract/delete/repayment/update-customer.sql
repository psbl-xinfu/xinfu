UPDATE cc_customer c 
SET 
	moneyleft = (c.moneyleft + r.factmoney) 
FROM cc_contract r 
WHERE r.code = ${fld:vc_code} AND c.code = r.customercode 
 and c.org_id =${def:org}  and r.org_id =${def:org}
