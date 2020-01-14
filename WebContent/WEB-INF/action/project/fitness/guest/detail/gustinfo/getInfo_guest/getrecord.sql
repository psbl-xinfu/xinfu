select
  	 code,
	name,
	(case sex when '0' then '女' when '1' then '男'  else '未填' end) as sex,
	mobile,
	birth,
	birthday,
	wx,
	qq,
	occupation,
	email,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Province' 
		and t.domain_value = cc_guest.province2::varchar 
	) as province,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'City' 
		and t.domain_value = cc_guest.city2::varchar
	) as city,
	addr,
	officename,
	officetel,
	officeaddr,
	urgent,
	othertel,
	remark,
	(select name from hr_staff where userlogin=cc_guest.mc 
	) as mc,
	created,
	guestnum
from 
	cc_guest 
where 
	code = ${fld:id} and org_id=${fld:menuorgid}
