UPDATE cc_cabinet 
SET 
	status = 1 
WHERE tuid = (
	SELECT get_arr_value(r.relatedetail, 1) FROM cc_contract r 
	WHERE r.code = ${fld:contractcode} and r.org_id = ${def:org}
)::integer AND org_id = ${def:org}
