SELECT (case when count(1)>0 then '1' else '0' end) as incode
FROM cc_cardcode 
WHERE ${field_name} = '${field_value}'
and incode is not null and incode!=''
and org_id = ${def:org}