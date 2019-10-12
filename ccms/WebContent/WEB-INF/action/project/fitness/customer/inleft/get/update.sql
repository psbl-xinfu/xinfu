update cc_inleft 
set cabinettempcode=${fld:getcabinettempcode}
where 
	code=${fld:leftcode}
	
	and org_id=${def:org}

