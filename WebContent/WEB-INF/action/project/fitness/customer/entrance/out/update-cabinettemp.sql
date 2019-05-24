UPDATE cc_cabinettemp
SET	status = 0,
	cardcode=null,
	customercode=null,
	cardtype=null,
	createdby=null,
	created=null
WHERE
	tuid = ${fld:rudge_code}
	and org_id = ${def:org}