select 
	staff.name,
	staff.userlogin,
	staff.mobile,
	(case when staff.status=0 then '离职' when staff.status=1 then '正常' end) as status,
	staff.remark,
	(select string_agg(org_name, '；') from hr_org org left join hr_staff_org s on s.org_id = org.org_id
		where s.user_id = staff.user_id) as org_name
from hr_staff staff
where staff.status in (0,1)
--管理员
and exists(
	select 1 from hr_skill skill 
	inner join hr_staff_skill ss on skill.skill_id = ss.skill_id
	where skill.skill_scope = '4' and ss.user_id = staff.user_id
)
--并且属于该门店
and (
	exists(
		select 1 from hr_org g where g.org_id = ${def:org} or pid = ${def:org}
	) or exists(
		select 1 from hr_org org 
		inner JOIN hr_staff_org s on s.org_id = org.org_id
		where (org.org_id=${def:org} or org.pid=${def:org}) and org.is_deleted=0
		and s.user_id = staff.user_id
	)
)
${filter}
order by staff.created desc
