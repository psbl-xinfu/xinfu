select
   code,
	name,
	sex,
	mobile,
	birth,
	birthday,
	
	wx,
	qq,
	mc,
	type,
	cardtype,
	card,
--
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
purpose,
participate,
brand,
ismember,
leave,
customtype,
gethobbit,
personalhobbit,
marriage,
children,
remark,
initmc,
created,
age,
level,
(select t.tuid from t_attachment_files t where t.pk_value = cc_guest.code and t.table_code = 'cc_guest' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
recommend,
(select   cc_customer.name from  cc_customer  where cc_guest.recommend=cc_customer.code) as recommend_name
from 
	cc_guest 
where 
	code = ${fld:code} and org_id=${def:org}
