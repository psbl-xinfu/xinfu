SELECT DISTINCT s.userlogin,s.name_en,s.name as staff_name
FROM hr_staff s 
WHERE s.userlogin = '${def:user}'