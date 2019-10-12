update cc_fillcard set
	status=1
where
	code=${fld:vc_code} and org_id = ${def:org} 
