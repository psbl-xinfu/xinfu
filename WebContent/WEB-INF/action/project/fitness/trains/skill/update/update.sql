UPDATE et_course_skill SET 
skill_id=${fld:skill_id},
courseid=${fld:course_id},
begin_date=${fld:begin_date},
end_date=${fld:end_date},
showorder=${fld:showorder},
updatedby='${def:user}',
updated={ts '${def:timestamp}'}
WHERE tuid=${fld:tuid};