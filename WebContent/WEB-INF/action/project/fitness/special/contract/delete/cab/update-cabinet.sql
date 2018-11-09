UPDATE cc_cabinet 
SET 
	status = 0
WHERE cabinetcode = (
	SELECT get_arr_value(r.relatedetail, 1) FROM cc_contract r WHERE r.code = ${fld:vc_code}
	and r.org_id =${def:org}
) and org_id =${def:org}
