UPDATE cc_classprepare set
	status=2
WHERE
	code = ${fld:cpcode} and org_id = ${fld:unionorgid}