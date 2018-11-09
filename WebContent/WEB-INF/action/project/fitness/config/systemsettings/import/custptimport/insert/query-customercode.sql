SELECT customercode
FROM cc_card 
WHERE ${field_name} = '${field_value}' and isgoon = 0
and org_id = ${def:org}
