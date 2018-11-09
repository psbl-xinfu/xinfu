UPDATE cc_card d
SET 
	status = 1 
FROM cc_contract r 
WHERE r.code = ${fld:vc_code} 
AND d.code = get_arr_value(r.relatedetail,1) AND d.isgoon = 0 
AND d.status = 0  and d.org_id = ${def:org} and r.org_id = ${def:org}
