select userlogin,name from hr_staff where status = 1 and userlogin = '${def:user}' and org_id = ${def:org}
union
select userlogin,name from hr_staff where status = 1
and 
(case when exists(
	(select 1 from hr_staff inner join (select user_id from hr_staff_skill inner join(
				select skill_id from hr_skill where skill_scope in ('1', '2') and org_id = ${def:org}
			) skill on skill.skill_id = hr_staff_skill.skill_id
		) hs on hs.user_id = hr_staff.user_id
		where userlogin = '${def:user}'  and org_id = ${def:org}
	)
) then 1=1 else 
	(userlogin in (select userlogin from hr_staff inner join (select user_id from hr_staff_skill inner join 
		(select skill_id from hr_skill where skill_scope = '1' and org_id = ${def:org}) skill on skill.skill_id = hr_staff_skill.skill_id
	) hs on hs.user_id = hr_staff.user_id
		where org_id = ${def:org}
	)) 
	end) and org_id = ${def:org}