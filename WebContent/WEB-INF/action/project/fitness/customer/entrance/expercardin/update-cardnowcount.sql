UPDATE cc_expercard_list 
SET 
	experlimit = (experlimit-${fld:nowcount}) 
WHERE code = ${fld:cardcode} and org_id = ${fld:unionorgid}
and expertype = 1

