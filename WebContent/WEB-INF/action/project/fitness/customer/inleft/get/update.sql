update cc_inleft 
set cabinettempcode=
(select tuid from cc_cabinettemp cab where cab.cabinettempcode=${fld:getcabinettempcode} and cab.org_id=${def:org} )
where 
	code=${fld:leftcode}
	
	and org_id=${def:org}

