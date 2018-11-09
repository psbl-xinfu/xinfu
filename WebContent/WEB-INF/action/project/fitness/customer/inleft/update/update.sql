update cc_inleft 
set cabinettempcode=(select tuid from cc_cabinettemp where cabinettempcode=${fld:newcabinettempcode} and org_id = ${def:org})
where 
	code=${fld:leftcode}
	and org_id=${def:org}

