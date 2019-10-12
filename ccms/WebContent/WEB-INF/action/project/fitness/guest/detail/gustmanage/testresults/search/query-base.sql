SELECT 
	code,
	guestcode,
	created
FROM cc_testresult 
WHERE status = 1 
 AND guestcode =${fld:s_guestid} and org_id = ${def:org}
