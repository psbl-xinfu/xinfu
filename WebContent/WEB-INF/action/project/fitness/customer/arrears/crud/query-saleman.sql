select 
  f.userlogin as userlogin,
  f.name as salename,
  name_en
from hr_staff f 
inner join hr_staff_skill sk on f.user_id = sk.user_id 
inner join hr_skill k on sk.skill_id = k.skill_id and f.org_id = k.org_id
WHERE (
	f.org_id = ${def:org} OR 
	charindex((SELECT org_path FROM hr_org WHERE org_id = ${def:org}), (SELECT org_path FROM hr_org WHERE hr_org.org_id = f.org_id)) >= 1 
)
  and f.user_id<>'100'
order  by  f.name_en