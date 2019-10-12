SELECT
	s.name,
	s.sex,
	s.mobile,
	s.user_id
FROM hr_staff s  
WHERE 
    s.org_id = ${def:org} and s.userlogin='${def:user}'

