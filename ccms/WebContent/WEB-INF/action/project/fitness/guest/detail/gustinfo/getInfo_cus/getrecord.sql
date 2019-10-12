select
  	 code,
	name,
	(case sex when '0' then '女' when '1' then '男'  else '未填' end) as sex,
	mobile,
	birth,
	birthday,
	wx,
	qq,
	(select s.name from hr_staff s where s.userlogin = mc) as mc,
	(case type when '0' then '会员介绍(BR)' when '1' then '访客介绍(VR)' when '2' then '其他介绍(OR)'  
	when '3' then '电话咨询(TI)' when '4' then '访客(WI)' when '5' then '外宣收集(DM)'when '6' then '购买名单' when '7' then '其他(other)'
	else '未填' end) as type,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Age' 
		and t.domain_value = cc_customer.age::varchar 
	) as age,
	(case cardtype when '0' then '身份' when '1' then '驾驶证' when '2' then '其他' else '未填' end) as cardtype,
	card,
	'中国' as nationality,
	(
		SELECT param_text FROM cc_config config WHERE config.category = 'Nation' and config.param_value = nation::varchar
			and config.org_id = (case when 	not exists(select 1 from cc_config c where c.org_id = ${fld:menuorgid} and c.category=config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${fld:menuorgid} end)
	) as nation,
	occupation,
	email,
	province,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Province' 
		and t.domain_value = cc_customer.province::varchar 
	) as province,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'City' 
		and t.domain_value = cc_customer.city::varchar 
	) as city,
	addr,
	officename,
	officetel,
	province2,
	city2,
	officeaddr,
	urgent,
	othertel,
	(
		SELECT param_text
		FROM cc_config 
		WHERE category = 'PTAim'
		and cc_config.org_id = (case when 
			not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cc_config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
		and param_value = cc_customer.aim::varchar 
	) as purpose,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Leave' 
		and t.domain_value = cc_customer.leave::varchar 
	) as leave,
	(
		SELECT param_text FROM cc_config config WHERE config.category = 'ConsultingHabit' and config.param_value = gethobbit::varchar
			and config.org_id = (case when 	not exists(select 1 from cc_config c where c.org_id = ${fld:menuorgid} and c.category=config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${fld:menuorgid} end)
	) as gethobbit,
	(
		SELECT param_text FROM cc_config config WHERE config.category = 'PersonalHobbies' and config.param_value = personalhobbit::varchar
			and config.org_id = (case when 	not exists(select 1 from cc_config c where c.org_id = ${fld:menuorgid} and c.category=config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${fld:menuorgid} end)
	) as personalhobbit,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'marital_status' 
		and t.domain_value = cc_customer.marriage::varchar 
	) as marriage,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Children' 
		and t.domain_value = cc_customer.children::varchar 
	) as children,
	remark,
	initmc,
	(select ct.name from cc_customer ct where ct.code = cc_customer.recommend and ct.org_id = ${fld:menuorgid} limit 1) as recommend_name,
	(select t.tuid from t_attachment_files t where t.pk_value = cc_customer.code and t.table_code = 'cc_customer' and t.org_id= ${fld:menuorgid} order by t.tuid desc limit 1) as imgid,
	created,
	cardcode
from 
	cc_customer
where 
	code = ${fld:id} and org_id=${fld:menuorgid}
