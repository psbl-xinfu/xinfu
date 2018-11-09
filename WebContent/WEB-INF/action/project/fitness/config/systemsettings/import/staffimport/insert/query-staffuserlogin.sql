SELECT (case when count(1)>0 then '1' else '0' end) as userlogin
FROM hr_staff 
WHERE ${field_name} = '${field_value}'
