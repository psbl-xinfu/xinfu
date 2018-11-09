SELECT 
	COUNT(1) as guestpreparenum
FROM cc_guest_prepare 
WHERE org_id = ${def:org} and status = 1
and preparedate::date = ('${def:date}'::date + interval '1 D')::date
