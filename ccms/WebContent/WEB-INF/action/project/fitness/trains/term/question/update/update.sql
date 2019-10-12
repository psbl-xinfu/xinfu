UPDATE et_term_question SET 
question_name=${fld:question_name},
question_code=${fld:question_code},
question_score=${fld:question_score},
question_type=${fld:question_type},
showorder=${fld:showorder},
updatedby='${def:user}',
updated={ts '${def:timestamp}'}
WHERE tuid=${fld:tuid};