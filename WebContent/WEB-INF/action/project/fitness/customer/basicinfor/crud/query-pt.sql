SELECT DISTINCT s.user_id, s.userlogin, s.name ,s.name_en
FROM hr_staff s 
WHERE s.staff_category in (1,4) 
AND s.is_member = 0 AND s.i_status = 1 
AND (
	s.org_id = ${def:org} OR 
	charindex((SELECT org_path FROM hr_org WHERE hr_org.org_id = ${def:org}), (SELECT org_path FROM hr_org WHERE hr_org.org_id = s.org_id)) >= 1 
)
order  by  s.name_en

