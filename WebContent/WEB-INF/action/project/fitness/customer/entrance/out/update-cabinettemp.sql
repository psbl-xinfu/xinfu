UPDATE cc_cabinettemp
SET	status = 0,
	cardcode=null,
	customercode=null,
	cardtype=null,
	createdby=null,
	created=null
WHERE
	cabinettempcode = ${fld:rudge_code}
	and  ${fld:rudge_code} is not null and  ${fld:rudge_code} != '' 
	and org_id = ${def:org}