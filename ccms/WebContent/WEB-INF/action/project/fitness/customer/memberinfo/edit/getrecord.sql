select
    code,
	name,
	sex,
	mobile,
	birth,
	birthday,
	purpose,
	aim,
	wx,
	qq,
	mc,
	type,
	cardtype,
	card,
	nationality,
	nation,
	occupation,
	email,
	
	province,
	city,
	addr,
	officename,
	officetel,
	
	province2,
	city2,
	officeaddr,

	urgent,
othertel,
leave,
gethobbit,
personalhobbit,
marriage,
children,
remark,
initmc,
created,
age,
(select t.tuid from t_attachment_files t where t.pk_value = r.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	(select name from cc_customer where code = r.recommend and org_id = ${def:org} limit 1) as  recommend_name,
	concat(COALESCE((select memberhead from hr_org where org_id = ${def:org}),''), r.mobile) as userlogin,
	user_id,
	cardcode as custcardcode
--(select   cc_customer.name from  cc_customer  where cc_guest.recommend=cc_customer.code) as recommend_name
from 
	cc_customer r
where 
	code = ${fld:code}
