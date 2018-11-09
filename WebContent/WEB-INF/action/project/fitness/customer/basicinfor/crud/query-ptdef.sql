SELECT DISTINCT s.user_id, s.userlogin, s.name ,s.name_en
FROM hr_staff s 
WHERE s.staff_category in (2,4) 
AND s.is_member = 0 AND s.i_status = 1 
AND s.org_id = ${def:org}
order by  s.name_en
