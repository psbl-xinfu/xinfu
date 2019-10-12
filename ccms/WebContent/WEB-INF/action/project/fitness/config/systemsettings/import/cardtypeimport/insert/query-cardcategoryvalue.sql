SELECT code as cardcategory
FROM cc_cardcategory 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org}
