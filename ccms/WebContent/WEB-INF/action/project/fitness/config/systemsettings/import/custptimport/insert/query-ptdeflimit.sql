SELECT count(1) as count
FROM cc_ptdef_limit 
WHERE ${field_name} = '${field_value}'
and ${field_name1} = '${field_value1}'
and org_id = ${def:org}
