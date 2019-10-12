SELECT f.user_id, f.userlogin, f.name, f.name_en  
FROM hr_staff f 
WHERE 
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else f.userlogin = '${def:user}' end)
AND f.is_member = 0 AND f.status = 1 
AND f.org_id = ${def:org} 
and f.user_id<>100
GROUP BY f.user_id, f.userlogin, f.name,f.name_en  
