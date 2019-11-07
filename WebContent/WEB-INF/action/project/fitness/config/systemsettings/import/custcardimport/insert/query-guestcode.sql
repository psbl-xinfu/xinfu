SELECT code
FROM cc_guest 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}