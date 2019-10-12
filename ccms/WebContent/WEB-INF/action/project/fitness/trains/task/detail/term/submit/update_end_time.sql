UPDATE et_term_score
   SET end_time='${def:timestamp}'
   WHERE tuid=${fld:s_term_score_id}
   