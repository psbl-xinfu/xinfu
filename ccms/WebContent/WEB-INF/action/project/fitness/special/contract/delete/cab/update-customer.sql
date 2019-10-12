UPDATE cc_customer c 
SET 
	moneyleft = (
		CASE WHEN (r.normalmoney-r.factmoney) > 0 
		THEN (c.moneyleft-(r.normalmoney-r.factmoney)) 
		ELSE c.moneyleft END
	) 
FROM cc_contract r 
WHERE r.code = ${fld:vc_code} AND c.code = r.customercode 
and r.org_id = ${def:org} and c.org_id = ${def:org}
