select 
	(select count(1) from hr_staff 
		inner join (select user_id from hr_staff_skill 
			inner join (select skill_id from hr_skill where skill_scope in ('1', '4') and org_id = ${def:org}) skill
			on skill.skill_id = hr_staff_skill.skill_id
		) hs on hs.user_id = hr_staff.user_id
		where status = 1 and org_id = ${def:org}) as ptnum,
	sum(case when t.count>0 and t.count<=4 then 1 else 0 end) as onenum,
	sum(case when t.count>4 and t.count<=12 then 1 else 0 end) as twonum,
	sum(case when t.count>12 then 1 else 0 end) as threenum
from
(select 
	ptid,count(1) as count
from cc_ptlog
where created::date>=${fld:fdate} and created::date<=${fld:tdate}
and ptid is not null and ptid !='' and org_id = ${def:org}
GROUP BY ptid
) as t
