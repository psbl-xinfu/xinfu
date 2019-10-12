UPDATE cc_cabinet_rent c 
SET 
	enddate = (CASE get_arr_value(r.relatedetail,3) WHEN '' THEN NULL ELSE get_arr_value(r.relatedetail,3) END)::date 
FROM cc_contract r 
WHERE r.code = ${fld:vc_code} and r.org_id = ${def:org}
AND c.customercode = get_arr_value(r.relatedetail,0) 
AND c.cabinetcode = get_arr_value(r.relatedetail,1) 
and c.org_id = ${def:org}