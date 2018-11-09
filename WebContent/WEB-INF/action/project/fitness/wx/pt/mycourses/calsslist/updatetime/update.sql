UPDATE et_course_log
SET currentsecond=${fld:currentsecond},
updatedby='${def:user}',
updated= {ts '${def:timestamp}'} 
WHERE courseid=${fld:courseid}
  and
      classid=${fld:classid}
  and
  	  course_skill_id=${fld:course_skill_id}
  and
  	  skill_id=${fld:skill_id}
  and
  	  userlogin='${def:user}'