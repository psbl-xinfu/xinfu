update cc_guest set
	status= 99
where
	code = ${fld:vc_code} and org_id = ${def:org}  