select	
	tuid as classid,
	courseid,
	${fld:courseskillid} as course_skill_id,
	(select skill_id  from et_course_skill where tuid = ${fld:courseskillid}) as skill_id,
	(
		select g.status from et_course_log g 
		where g.courseid = c.courseid and g.classid = c.tuid
		and g.course_skill_id = ${fld:courseskillid} order by g.tuid desc limit 1
	) as status,
	(
		select g.currentsecond from et_course_log g 
		where g.courseid = c.courseid and g.classid = c.tuid
		and g.course_skill_id = ${fld:courseskillid} order by g.tuid desc limit 1
	) as currentsecond,
	class_name,
	(select timelength from et_resource where tuid=resourceid and status=1) as  timelength,
	(select videourl from et_resource where tuid=resourceid and status=1) as  videourl
from 
	et_class c 
where 
	courseid = ${fld:courseid}
	and status=1
	order by showorder
