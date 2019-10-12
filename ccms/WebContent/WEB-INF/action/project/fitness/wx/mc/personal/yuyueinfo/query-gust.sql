SELECT 
name,
mobile
FROM cc_guest
where code=${fld:code}
and org_id=${def:org}
