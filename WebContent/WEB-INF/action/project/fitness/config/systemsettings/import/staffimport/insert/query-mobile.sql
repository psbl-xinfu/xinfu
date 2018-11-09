SELECT (case when count(1)>0 then '1' else '0' end) as mobile
FROM hr_staff 
WHERE ${field_name} = '${field_value}' and org_id = ${def:org}