UPDATE cc_cabinettemp
SET status = 1,
	cardcode=inleft.cardcode,
	customercode=inleft.customercode,
	cardtype=inleft.cardtype,
	type=0,
	createdby='${def:user}',
	created={ts'${def:timestamp}'}
from cc_inleft inleft 
WHERE 1=1
	and inleft.code = ${fld:leftcode}
	and inleft.org_id = ${def:org}
	and cc_cabinettemp.tuid=${fld:getcabinettempcode}
	and cc_cabinettemp.org_id = inleft.org_id
