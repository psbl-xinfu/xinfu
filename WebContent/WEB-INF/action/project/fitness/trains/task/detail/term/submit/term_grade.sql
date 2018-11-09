UPDATE et_term_score 
SET term_score=
  ${fld:total_score}
WHERE tuid=${fld:s_term_score_id}
