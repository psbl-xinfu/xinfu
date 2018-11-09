select 
	tp.groupid,
	tp.groupname,
	count(tp.courseid) as coursenum,
	sum(tp.classnum) as classnum,
	(select r.coverurl from et_resource r where r.tuid = min(tp.coverurlid)) as coverurl,
	(
		case when not exists(
			select 1 from et_course_log l 
			inner join et_course_skill ck on ck.tuid = l.course_skill_id 
			where ck.groupid = tp.groupid and l.userlogin = '${def:user}' 
			and l.status = 1 
		) then '未开始' when (
			select count(1) from et_class c 
			inner join et_course_group cg on c.courseid = cg.courseid 
			inner join et_course_skill cs on cs.groupid = tp.groupid 
			where cg.courseid = cs.courseid and c.status = 1 and cg.status = 1 and cs.status = 1 
			and exists(
				select 1 from et_course_log l where cs.tuid = l.course_skill_id and l.status = 1 
			)
		) >= sum(tp.classnum) then '已完成' else '进行中' end
	) as status,
	(
		select g.remark from et_group g 
		where tp.groupid = g.tuid and g.status = 1 and g.org_id = ${def:org}
	) as remark 
from (
	select 
		ck.groupid,
		g.groupname,
		ck.courseid,
		(
			select count(1) from et_class c 
			inner join et_course_group cg on c.courseid = cg.courseid 
			where cg.courseid = ck.courseid and c.status = 1 and cg.status = 1 
		) as classnum,
		(
			select min(r.tuid) from et_resource r 
			inner join et_class e on e.resourceid = r.tuid 
			where ck.courseid = e.courseid and r.status = 1 and e.status = 1 
		) as coverurlid
	from et_course_skill ck 
	inner join et_group g on g.tuid = ck.groupid 
	where ck.begin_date<='${def:date}'::date 
	and ck.end_date>='${def:date}'::date 
	and ck.status = 1 
	and exists(
		select 1 from hr_staff f 
		inner join hr_staff_skill fk on f.user_id = fk.user_id
		inner join hr_skill k on k.skill_id = fk.skill_id 
		where f.userlogin ='${def:user}' and k.skill_id = ck.skill_id 
	) 
) as tp 
group by tp.groupid, tp.groupname 
order by tp.groupid desc
