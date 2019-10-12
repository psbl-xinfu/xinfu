SELECT count(1) AS msgnum FROM cc_message 
WHERE recuser = '${def:user}' AND status = 1 AND remind = 1 
and viewtime is null
