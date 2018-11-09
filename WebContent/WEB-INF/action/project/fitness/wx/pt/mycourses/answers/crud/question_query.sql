select
question_name,
tuid,
question_type,
question_score
from  et_term_question
where termid=${fld:termid}
order by showorder,created desc