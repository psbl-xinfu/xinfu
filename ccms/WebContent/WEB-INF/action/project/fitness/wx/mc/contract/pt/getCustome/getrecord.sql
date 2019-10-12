SELECT 
name
FROM cc_customer
where mobile=${fld:code}
and org_id=${def:org}

