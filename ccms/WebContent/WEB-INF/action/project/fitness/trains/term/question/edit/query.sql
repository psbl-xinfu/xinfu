SELECT 
tuid,
question_name,
question_code,
question_score,
question_type,
showorder
FROM 
et_term_question WHERE tuid=${fld:id};
   