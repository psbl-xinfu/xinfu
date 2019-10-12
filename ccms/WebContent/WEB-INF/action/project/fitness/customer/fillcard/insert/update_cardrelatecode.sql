update cc_card set
	relatecode=${fld:new_vc_code}
where
	relatecode=${fld:cardcode} and org_id = ${def:org} and isgoon = 0
