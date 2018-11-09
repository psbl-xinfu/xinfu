select 
	g.classid,
	r.coverurl,
	r.videourl
from et_course_log g
left join et_class c on g.classid = c.tuid
left join et_resource r on c.resourceid = r.tuid
where g.userlogin = '${def:user}' and g.status != 0 
and g.courseid = ${fld:courseid}
order by g.created desc limit 1