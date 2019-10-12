update cc_guest_prepare set 
	status=4
where
	code = ${fld:tuid} and org_id = ${def:org}
