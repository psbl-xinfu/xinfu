select
	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',
		(select  p.status from cc_guest_prepare p where  p.guestcode = r.code and p.org_id=${def:org}   order by p.code desc limit 1)::varchar,'','"
	code1="',r.status::varchar,'','"
	value="',r.code::varchar,'','"  
	code2="',r.user_id::varchar,'','"
	code3="',(select userlogin from hr_staff where user_id=r.user_id and org_id=r.org_id),'','"
></label>') as application_id,
	r.code,
	(select t.tuid from t_attachment_files t where t.pk_value = r.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	r.name as vc_name,
	(case r.sex when '0' then '女' when '1' then '男' else '未知' end) as i_sex,
	(select hr_staff.name  from hr_staff where hr_staff.userlogin=r.mc and hr_staff.org_id = '${def:org}') as vc_mc,
	
	(select count(1) from cc_comm where customercode = r.code and cc_comm.org_id = r.org_id) as tonghuanum,
	(select created from cc_comm where customercode = r.code and cc_comm.org_id = r.org_id order by created desc  LIMIT 1) as tonghuadate,
	(select intime from cc_inleft where customercode = r.code and cc_inleft.org_id = r.org_id order by intime desc LIMIT 1) as daodiandate,
	  
 	(select  enddate  from cc_card  where cc_card.customercode = r.code and cc_card.isgoon = 0  order by enddate desc limit 1 )as enddate
 	,(case when (${fld:period_day}::int-('${def:date}'::date -(select created from cc_mcchange where customercode = r.code order by created desc limit 1)::date))<1 then 0 
 	else (${fld:period_day}::int-('${def:date}'::date -(select created from cc_mcchange where customercode = r.code order by created desc limit 1)::date)) end) as datenum,
 	r.mobile
from  cc_customer r 
where EXISTS(
	SELECT 1 FROM cc_card d 
	WHERE r.code = d.customercode AND d.isgoon = 0 AND d.org_id = r.org_id AND d.status != 0 AND d.status != 6
) 
/* 判断当前登录人是否是私教，私教查询全部会员*/
and (case when (select skill_scope from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}')::integer = 1 then 1=1 else 
/** 会籍顾问只能查看自己的数据 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else r.mc = '${def:user}' end) end)
AND r.org_id = ${def:org} and r.status!=0
 ${filter}
 
 ${orderby}