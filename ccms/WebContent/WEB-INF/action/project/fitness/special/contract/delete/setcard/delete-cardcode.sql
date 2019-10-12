DELETE FROM cc_cardcode
where cardcode = (
	SELECT get_arr_value(relatedetail,1) FROM cc_contract WHERE code = ${fld:vc_code}
	and org_id = ${def:org}
) and org_id = ${def:org}
