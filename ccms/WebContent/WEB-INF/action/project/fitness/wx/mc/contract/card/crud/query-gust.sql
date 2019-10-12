SELECT 
name,
mobile,
'/images/icon_head.png' as headpic
FROM cc_guest
where code=${fld:code}
and org_id=${def:org}
