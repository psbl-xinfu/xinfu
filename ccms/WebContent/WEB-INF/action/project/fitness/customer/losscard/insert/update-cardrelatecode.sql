update cc_card set 
	status=4 
where
	relatecode = ${fld:cardcode} and org_id = ${def:org} and isgoon = 0
