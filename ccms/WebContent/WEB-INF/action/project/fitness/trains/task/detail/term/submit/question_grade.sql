UPDATE et_term_question_score q_s_o
SET question_score=(
    CASE WHEN (SELECT q.question_type FROM et_term_question q WHERE q.tuid=q_s_o.term_question_id)=1 
    THEN (SELECT SUM(q_s.question_score) FROM et_term_question_score q_s WHERE q_s.term_question_id=q_s_o.term_question_id AND q_s.term_score_id=${fld:s_term_score_id})
    ELSE q_s_o.question_score END)
WHERE q_s_o.term_score_id=${fld:s_term_score_id}

   