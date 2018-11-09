UPDATE cc_ptrest 
SET 
	ptleftcount = ptleftcount - ${fld:ptclasscount}
WHERE code = ${fld:ptrestcode} and org_id = ${def:org}
