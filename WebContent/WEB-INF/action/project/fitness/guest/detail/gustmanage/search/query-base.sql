select
	 concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',
	(select  p.status from cc_guest_prepare p where  p.guestcode = g.code and p.org_id=${def:org}   order by p.code desc limit 1) 
	::varchar,'','" code1="',g.status::varchar,'" value="',g.mobile::varchar,'','" > </label>') as application_id,
	g.code as vc_code,
	g.name as vc_name,
	(case g.sex when '0' then '女' when '1' then '男' when '2' then '未知' else '' end) as i_sex,
	g.age as i_age,
	g.level as vc_level,
	g.mobile as vc_mobile,
	g.othertel as vc_othertel,
	g.type as i_type,
	g.created::date as vc_itime,
	(select name from hr_staff where userlogin=g.mc) as vc_newmc,
	(SELECT param_text FROM cc_config WHERE category = 'GuestType' and param_value::int = type and org_id = ${def:org}) as type,
	(select t.domain_text_cn 
		from cc_comm c 
		left join t_domain t on  t.domain_value=c.stage  and t.namespace='CommStage'
		where  g.code=c.guestcode and c.org_id=${def:org} order by c.created desc limit 1
	) as domain_text_cn,--沟通阶段
	(select (case when commresult=0 then '免打扰'
			when commresult=1 then '下次通话提醒'
			when commresult=2 then '预约到店'
			when commresult=3 then '成交'
		end) from cc_comm c 
		where g.code=c.guestcode and c.org_id=${def:org} order by c.created desc limit 1) as commresult,--沟通状态
	(case g.public when '0' then '否' when '1' then '是' else '' end) as i_public,
	(case g.status when '0' then '无效' when '1' then '有效' when '50' then '免打扰/电话预约' when '80' then '过期' when '99' then '成交' else '' end) as i_status
	,(SELECT g.updated+concat(config.param_value,'day')::interval FROM cc_config config WHERE 
	config.category = 'GuestOutdate' and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as fenpei,
		(case age when '0' then '18岁以下' when '1' then '18-24' when '2' then '25-30'  
	when '3' then '31-40' when '4' then '41-50' when '5' then '51-60'when '6' then '60以上' 
	else '未填' end) as age
from cc_guest g 
left join hr_staff f on f.userlogin = g.mc
/** 普通会籍只能查看自己的资源 */
WHERE 
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
and g.org_id=${def:org} and g.status!=99--成交资源不显示
${filter} 
${orderby}



