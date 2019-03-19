UPDATE cc_cabinettemp
SET status = 1,
	cardcode=${fld:cardcode},
	customercode=${fld:cust_code},
	cardtype=${fld:cardtype},
	type=0,
	createdby='${def:user}',
	created='${def:date}'
WHERE
	cabinettempcode = ${fld:rudge_code}
	and  ${fld:rudge_code} is not null and  ${fld:rudge_code} != '' 
	and org_id = ${def:org}