update cc_inleft 
set cabinettempcode=null
where 
	code=${fld:leftcode}
	and org_id=${def:org}

