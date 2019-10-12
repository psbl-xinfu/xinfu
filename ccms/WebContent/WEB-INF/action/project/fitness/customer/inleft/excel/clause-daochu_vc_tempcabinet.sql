and
	inleft.cabinettempcode::int = 
	(select tuid from cc_cabinettemp where cabinettempcode=${fld:daochu_vc_tempcabinet} and org_id= ${def:org})
