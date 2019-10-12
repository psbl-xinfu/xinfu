SELECT
name,
(case when sex=1 then '男' else '女' end) as sex,
mobile,
user_id,
(select name from hr_staff where userlogin=cc_customer.mc and org_id = ${def:org}) as mc,--销售员
(select name from hr_staff where userlogin='${def:user}'   and org_id = ${def:org}) as nicheng--昵称
FROM cc_customer 
where code=${fld:customercode}
and org_id=${def:org}

