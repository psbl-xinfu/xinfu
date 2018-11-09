select
t.item_name,
t.item_score,
t.tuid as tid,
q.question_type,
q.tuid
from 
et_term_item  t
left join et_term_question q on q.tuid=t.questionid
where
t.questionid=${fld:id}
order by t.showorder,t.created 