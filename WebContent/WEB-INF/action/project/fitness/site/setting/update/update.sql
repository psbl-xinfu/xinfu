update cc_sitedef set 
	sitename=${fld:sitename},
	sitetype=${fld:sitetype},
	opening_date=${fld:opening_date},
	closed_date=${fld:closed_date},
	block_price=${fld:block_price},
	block_maxnum=${fld:block_maxnum},
	group_price=${fld:group_price},
	group_minnum=${fld:group_minnum},
	group_maxnum=${fld:group_maxnum},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'},
	remark=${fld:remark}
where
	code = ${fld:code} and org_id = ${def:org}

	
