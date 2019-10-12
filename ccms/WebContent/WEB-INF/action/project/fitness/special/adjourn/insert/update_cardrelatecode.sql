update cc_card set
	enddate=enddate+${fld:adjourndays},
	remark=${fld:remark}
where 
	relatecode=${fld:cardcode} and isgoon = 0 and org_id = ${def:org}
