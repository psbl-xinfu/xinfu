SELECT 
	code as ptdefid
	,ptlevelname
	,(CASE WHEN ptfee IS NULL THEN 0 ELSE ptfee END) AS ptfees
	,scale
	,remark 
FROM cc_ptdef d 
WHERE status = 1 
AND reatetype != 1 
AND org_id = ${def:org} 
AND (
	${fld:ptid} IS NULL OR ${fld:ptid} = '' OR EXISTS(
		SELECT 1 FROM cc_ptdef_limit t 
		WHERE d.code = t.ptdefcode AND t.pt = ${fld:ptid} 
		AND t.org_id = d.org_id
	)
)