UPDATE cc_card d
SET 
	customercode = (
		SELECT get_arr_value(p.relatedetail,2) FROM cc_operatelog p 
		WHERE p.pk_value = ${fld:vc_code} AND p.opertype = '48'
		and p.org_id = ${def:org}
	) 
FROM cc_contract r 
WHERE r.code = ${fld:vc_code} 
AND d.code = get_arr_value(r.relatedetail,1) AND d.isgoon = 0
 and d.org_id =${def:org} and r.org_id =${def:org}

