SELECT (case when count(1)>0 then '1' else '0' end) as officename
FROM cc_guest 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}