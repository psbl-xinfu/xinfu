and
	inleft.cabinettempcode = 
	(select tuid from cc_cabinettemp where cabinettempcode=${fld:vc_tempcabinet} and org_id= ${def:org})::varchar
