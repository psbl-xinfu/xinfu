SELECT userlogin
FROM hr_staff 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}
