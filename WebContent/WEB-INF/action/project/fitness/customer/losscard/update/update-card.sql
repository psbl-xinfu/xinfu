update cc_card set 
	status=1 
where
	code = ${fld:cardcode} and org_id = ${def:org} and isgoon = 0
