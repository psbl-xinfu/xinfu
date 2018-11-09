SELECT 
tuid AS term_score_id
FROM et_term_score 
WHERE  userlogin='${def:user}'
ORDER BY tuid DESC LIMIT 1


   