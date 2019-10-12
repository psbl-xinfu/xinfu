SELECT (
	SELECT t.status 
	FROM cc_contract t 
	WHERE t.code = ${fld:contractcode} 
	AND t.org_id = ${def:org}
) AS status,
(
	SELECT t.isaudit 
	FROM cc_contract t 
	WHERE t.code = ${fld:contractcode} 
	AND t.org_id = ${def:org}
) AS isaudit