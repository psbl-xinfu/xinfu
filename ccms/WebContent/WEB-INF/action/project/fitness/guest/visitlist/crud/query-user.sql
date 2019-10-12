SELECT s.user_id, s.userlogin, s.name 
FROM hr_staff s 
WHERE s.data_limit = 1 
AND s.userlogin = '${def:user}' 
and s.org_id = ${def:org}