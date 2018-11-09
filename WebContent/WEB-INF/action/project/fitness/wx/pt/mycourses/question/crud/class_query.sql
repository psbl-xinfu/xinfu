select
course_name,
( 
select max(term_score) from  et_term_score where termid=et_course.termid  and  term_date::date<=${fld:end_date}::date  
)as term_score
from  et_course
where tuid=${fld:courseid}