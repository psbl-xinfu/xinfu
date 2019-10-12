UPDATE cc_trainplan 
SET 
	status = 0 
WHERE code in (select regexp_split_to_table(${fld:id},',') from dual)
and org_id = ${def:org}
