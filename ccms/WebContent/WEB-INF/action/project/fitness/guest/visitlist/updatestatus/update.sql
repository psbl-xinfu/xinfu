update cc_guest_prepare set 
	status= 5 
where
	code = ${fld:code} and org_id = ${def:org}