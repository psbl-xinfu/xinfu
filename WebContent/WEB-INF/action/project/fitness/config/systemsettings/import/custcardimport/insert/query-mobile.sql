SELECT (case when count(1)>0 then '1' else '0' end) as mobilecount
FROM cc_thecontact 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}
