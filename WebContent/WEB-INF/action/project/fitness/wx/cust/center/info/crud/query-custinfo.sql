SELECT 
name,
sex,
mobile,
user_id,
(select name from hr_staff where userlogin='${def:user}'   and org_id = ${def:org}) as nicheng--昵称
FROM cc_customer 
where code=${fld:customercode}
and org_id=${def:org}

