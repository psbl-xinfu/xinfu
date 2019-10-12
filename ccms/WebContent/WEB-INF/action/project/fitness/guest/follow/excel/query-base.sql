(select
	g.code as vc_code,
	g.name as vc_name,
	(case g.sex when 0 then '女' when 1 then '男' when 2 then '未知' else '' end) as i_sex,
	g.age as i_age,
	g.level as vc_level,
	g.mobile as vc_mobile,
	g.othertel as vc_othertel,
	g.type as i_type,
	g.created::date as vc_itime,
	(select name from hr_staff where userlogin=g.mc) as vc_newmc,
	(select name from hr_staff where userlogin=g.initmc) as vc_oldmc,
	(select count(1) from cc_comm c where g.code=c.guestcode and c.org_id = g.org_id) as count_call,
	(select v.created::date from cc_guest_visit v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_visititime,
	(select v.created::date from cc_comm v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_callitime,
	'否' as i_public,
	(case g.status when 0 then '无效' when 1 then '有效' when 50 then '免打扰/电话预约' when 80 then '过期' when 99 then '成交' else '' end) as i_status,
	g.updated AS _vc_fpdate,
	(case when (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_mcchange where guestcode = g.code order by created desc limit 1)::date))<1 then 0 
 	else (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_mcchange where guestcode = g.code order by created desc limit 1)::date)) end) as num_days,
	g.created,
	(select comm.nexttime
		from cc_comm comm where comm.guestcode = g.code and comm.org_id = g.org_id order by comm.created desc limit 1) as preparedate,
	(case when (select count(1) from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org})>0 then '已跟进' else '未跟进' end) as followup
	
from cc_guest g 
left join hr_staff f on f.userlogin = g.mc
/** 普通会籍只能查看自己的资源 */
WHERE g.org_id = ${def:org} and g.status != 99
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
${filter} )

union
(
select
	g.code as vc_code,
	g.name as vc_name,
	(case g.sex when 0 then '女' when 1 then '男' when 2 then '未知' else '' end) as i_sex,
	g.age as i_age,
	g.level as vc_level,
	g.mobile as vc_mobile,
	g.othertel as vc_othertel,
	g.type as i_type,
	g.created::date as vc_itime,
	(select name from hr_staff where userlogin=g.mc) as vc_newmc,
	(select name from hr_staff where userlogin=g.initmc) as vc_oldmc,
	(select count(1) from cc_comm c where g.code=c.guestcode and c.org_id = g.org_id) as count_call,
	(select v.created::date from cc_guest_visit v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_visititime,
	(select v.created::date from cc_comm v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_callitime,
	'是' as i_public,
	(case g.status when 0 then '无效' when 1 then '有效' when 50 then '免打扰/电话预约' when 80 then '过期' when 99 then '成交' else '' end) as i_status,
	g.updated AS _vc_fpdate,
	(case when (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_mcchange where guestcode = g.code order by created desc limit 1)::date))<1 then 0 
 	else (${fld:daochu_period_day}::int-('${def:date}'::date -(select created from cc_mcchange where guestcode = g.code order by created desc limit 1)::date)) end) as num_days,
	g.created,
	(select comm.nexttime
		from cc_comm comm where comm.guestcode = g.code and comm.org_id = g.org_id order by comm.created desc limit 1) as preparedate,
	(case when (select count(1) from cc_comm comm where comm.preparecode = 
		(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
		and comm.org_id = ${def:org})>0 then '已跟进' else '未跟进' end) as followup
FROM cc_public p
inner join cc_guest g on p.guestcode = g.code and p.org_id = g.org_id
where p.org_id = ${def:org} and p.status = 0
${filter}
)

order by created desc
