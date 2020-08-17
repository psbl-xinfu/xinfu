SELECT DISTINCT s.user_id, s.userlogin, s.name, s.name_en 
FROM hr_staff s 
where
s.userlogin = '${def:user}' 