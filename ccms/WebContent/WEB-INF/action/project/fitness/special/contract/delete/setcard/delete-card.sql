DELETE FROM cc_card 
WHERE code = (
	SELECT get_arr_value(relatedetail,1) FROM cc_contract WHERE code = ${fld:vc_code}
	and org_id = ${def:org}
) and isgoon = 0 and org_id = ${def:org}
