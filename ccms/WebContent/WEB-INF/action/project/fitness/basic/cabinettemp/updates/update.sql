update cc_cabinettemp set
	status=0,
	cardcode=null,
	customercode=null,
	cardtype=null,
	createdby=null,
	created=null
where org_id=${def:org} and status!=2 and  physics_status!=0