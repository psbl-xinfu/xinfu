UPDATE cc_contract 
SET 
	stage_times_pay = stage_times_pay - 1 
WHERE code = (
	SELECT relatecode FROM cc_contract WHERE code = ${fld:vc_code} and org_id =${def:org}
) AND stage_times > 1 and org_id =${def:org}
