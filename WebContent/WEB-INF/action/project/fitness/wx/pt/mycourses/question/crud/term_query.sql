 select 
 count(*)as questionnum,
 (select count(*) from et_term_score where  termid=${fld:termid}  )as answernum
from 
et_term_question 
where termid=${fld:termid}
		 
