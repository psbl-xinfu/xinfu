SELECT code as procode,courname
FROM cc_course 
where status=1 and isgood=1 order by code desc