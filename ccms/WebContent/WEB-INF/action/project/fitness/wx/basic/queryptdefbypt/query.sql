SELECT 
	code
	,ptlevelname
	,(CASE WHEN ptfee IS NULL THEN 0 ELSE ptfee END) AS ptfee
	,scale
	,remark 
FROM cc_ptdef d 
WHERE status = 1 
AND reatetype != 1 
AND org_id = ${def:org} 
AND (
	${fld:pt} IS NULL OR ${fld:pt} = '' OR EXISTS(
		SELECT 1 FROM cc_ptdef_limit t 
		WHERE d.code = t.ptdefcode AND t.pt = ${fld:pt} 
		AND t.org_id = d.org_id
	)
)