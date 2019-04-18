select
	concat('<input type="checkbox" code2="1" class="duoxuan" name="danxuan" value="', g.code, '">') as application_id,
	g.code as vc_code,
	g.name as vc_name,
	(case g.sex when 0 then '女' when 1 then '男' when 2 then '未知' else '' end) as i_sex,
	g.age as i_age,
	g.mobile as vc_mobile,
	g.othertel as vc_othertel,
	g.created::date as vc_itime,--录入日期
	(select name from hr_staff where userlogin=(case when
		g.mc is null then g.initmc
		else g.mc
	end)) as vc_newmc,
	(select v.created::date from cc_guest_visit v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_visititime,--最新到访日期
	(select v.created::date from cc_comm v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_callitime,--最新跟进日期
	p.entertime,--最新分配日期
	(case when
	(p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date >= 0 then '否'
	when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date < 0 then '是'
	end) as i_public,--是否进入公海
	(case when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date < 0
	then concat('已过期', now()::date-(p.grabtime::date+(${fld:period_day}||'day')::interval)::date,'天')
	when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date >= 0
	then concat('未过期', (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date ,'天')
	end) as num_days --保护期天数
from cc_guest g 
left join cc_public p on p.guestcode=g.code  and p.org_id=g.org_id
/** 普通会籍只能查看自己的资源 */
WHERE g.org_id = ${def:org} and g.status != 99
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
${filter} 
 order by p.grabtime desc
