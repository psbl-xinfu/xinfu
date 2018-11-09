SELECT code,ptfee
FROM cc_ptdef 
WHERE ${field_name} = '${field_value}'
and org_id = ${def:org} limit 1
