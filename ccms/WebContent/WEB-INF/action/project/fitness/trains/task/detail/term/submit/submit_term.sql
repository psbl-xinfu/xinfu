INSERT INTO et_term_question_score(
	tuid,
	term_question_id,
	term_item_id,
	term_score_id,
	question_score,
	remark
)VALUES(
    ${seq:nextval@seq_et_term_question_score},
    ${fld:question_id},
    coalesce(${fld:item_id},null::integer),
    ${fld:term_score_id},
    CASE WHEN (${fld:remark}='' OR ${fld:remark} is null) AND ((SELECT question_type FROM et_term_question WHERE tuid= ${fld:question_id})=2) THEN 0 
       ELSE coalesce((SELECT item_score FROM et_term_item WHERE tuid=${fld:item_id}),(SELECT question_score FROM et_term_question WHERE tuid=${fld:question_id})) END,
	coalesce(${fld:remark},null::varchar)
)


   