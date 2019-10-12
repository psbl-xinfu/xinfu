SELECT
name,
(case sex when '0' then '女' when '1' then '男'  else '未填' end) as sex,
mobile,

(SELECT param_text FROM cc_config WHERE category = 'GuestType' 
and param_value::int =cc_guest.type and org_id=cc_guest.org_id) as type,

(select name from hr_staff where userlogin=cc_guest.mc and org_id = ${def:org}) as mc,--销售员
(
	select t.domain_text_cn from t_domain t 
	where t.namespace = 'GuestLevel' 
	and t.domain_value = cast(cc_guest.level as char) 
) as level,

created::date as vc_itime,


(select comm.created from  cc_comm comm
   where  comm.operatortype=0  and cust_type=0   and comm.guestcode=cc_guest.code and comm.createdby='${def:user}'
   and comm.org_id = cc_guest.org_id order by comm.created desc limit 1 ) as lasttime,
   
   
  	(SELECT cc_guest.updated+concat(config.param_value,'day')::interval FROM cc_config config WHERE 
	config.category = 'GuestOutdate' and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as fenpei 
   
FROM cc_guest 
where code=${fld:guestcode}
and org_id=${def:org}