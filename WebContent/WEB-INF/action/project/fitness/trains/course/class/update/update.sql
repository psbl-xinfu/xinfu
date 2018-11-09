UPDATE et_class SET 
class_name=${fld:class_name},
courseid=${fld:courseid},
resourceid=${fld:resourceid},
showorder=${fld:showorder},
updatedby='${def:user}',
updated={ts '${def:timestamp}'}
WHERE tuid=${fld:tuid};