SELECT code as procode,proname
FROM cc_product 
where status=1 and isgood=1 order by code desc
