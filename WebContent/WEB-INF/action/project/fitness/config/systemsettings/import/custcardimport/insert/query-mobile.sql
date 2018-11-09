SELECT code,mobile
FROM cc_customer 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}
