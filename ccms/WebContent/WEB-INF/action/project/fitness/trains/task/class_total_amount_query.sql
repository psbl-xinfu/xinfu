SELECT
 COUNT(class.tuid)
FROM et_course_skill c_sk 
inner join hr_staff_skill sk on c_sk.skill_id = sk.skill_id 
INNER JOIN et_course_group  c_g ON c_g.courseid=c_sk.courseid
INNER JOIN et_group g ON c_g.groupid=g.tuid
INNER JOIN et_course  c ON  c_g.courseid=c.tuid
INNER JOIN et_class class ON  class.courseid=c.tuid
WHERE sk.userlogin='${def:user}' AND class.status=1 AND c.status=1
and c_sk.begin_date<='${def:date}'::date and c_sk.end_date >='${def:date}'::date 
AND c_sk.status = 1 AND c_g.status = 1 AND g.status = 1 