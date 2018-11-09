SELECT 
	p.ptid AS salemember
	,1::integer AS finishnum 
FROM cc_ptlog p 
WHERE p.created::date >= ${fld:fdate} AND p.created::date <= ${fld:tdate} 
AND p.org_id = ${def:org} AND p.status != 0 
