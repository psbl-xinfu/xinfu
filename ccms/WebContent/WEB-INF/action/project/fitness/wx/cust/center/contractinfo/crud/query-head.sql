SELECT 
user_id 
FROM cc_customer 
where
code=${fld:customercode}
and
org_id=${def:org}
