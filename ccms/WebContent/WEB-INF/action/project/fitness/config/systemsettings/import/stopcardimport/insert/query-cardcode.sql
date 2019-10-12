SELECT count(1) as cardcount
FROM cc_card 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org} and isgoon = 0