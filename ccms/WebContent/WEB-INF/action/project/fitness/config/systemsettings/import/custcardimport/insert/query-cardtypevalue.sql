SELECT code as cardtype
FROM cc_cardtype 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org} limit 1
