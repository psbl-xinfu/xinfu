update cc_guest_visit set 
	status= 3 
where
	code = ${fld:vi_vc_code} and org_id = ${def:org}                       