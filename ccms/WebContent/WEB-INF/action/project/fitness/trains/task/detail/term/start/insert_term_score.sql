INSERT INTO et_term_score(
   tuid,
   termid,
   userlogin,
   term_date,
   begin_time,
   end_time,
   term_score
)VALUES(
   ${seq:nextval@seq_et_term_score},
   (SELECT termid FROM et_course WHERE tuid=${fld:courseid}),
   '${def:user}',
   {ts '${def:timestamp}'},
   '${def:timestamp}',
   NULL,
   0
)


   