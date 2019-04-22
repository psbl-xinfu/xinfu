update cc_cabinettemp 
set status=0,
	cardcode=null,
	customercode=null,
	cardtype=null,
	createdby=null,
	created=null
where cabinettempcode=${fld:returncabinettempcode}
and org_id = ${def:org}

