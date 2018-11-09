update cc_classkq set 
	rules_name=${fld:vc_content},
	isrules=${fld:i_isrules},
	percent_value=${fld:f_bfb},
	fixed_value=${fld:f_gdz},
	remark=${fld:vc_remark},
	status=${fld:i_status}
where
	code = ${fld:vc_code} and org_id = ${def:org}
