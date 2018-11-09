insert into et_term_question_score
(

   tuid,
   term_question_id,--wenti id
 term_item_id,--dan an id
   term_score_id,
   question_score--问题得分
)
values
(
 ${seq:nextval@seq_et_term_question_score},
 ${fld:questionid},
 ${fld:answerid},
  ${seq:currval@seq_et_term_score},
   ${fld:questionscore}
)







