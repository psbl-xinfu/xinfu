select count(f.userlogin) as num from hr_staff  f
left join hr_staff_skill ts on f.userlogin=ts.userlogin
left join hr_skill s on s.skill_id=ts.skill_id and  s.skill_scope='1'
where f.userlogin=${fld:uid} and f.org_id=${fld:org}