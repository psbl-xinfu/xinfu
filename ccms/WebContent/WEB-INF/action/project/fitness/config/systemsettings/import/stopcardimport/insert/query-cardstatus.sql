SELECT (case when status = 1 then '1' else '2' end) as status
FROM cc_card 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org} and isgoon = 0