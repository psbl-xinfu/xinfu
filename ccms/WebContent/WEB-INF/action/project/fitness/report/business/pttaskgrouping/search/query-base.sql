select 
	team.team_id,
	team.team_name as staff_name,
	sum(t.custnum) as custnum,--会员数量
	sum(t.guestnum) as guestnum,--资源数量
	--跟进量
	sum(t.follow_target) as follow_target,--数量
	sum(t.rwfollow_target) as rwfollow_target,--任务
	concat((case when sum(t.rwfollow_target)=0 then 0 else sum(t.follow_target)/sum(t.rwfollow_target)*100 end)::NUMERIC(10, 2), '%') as gjcomplete,--完成率
	--体侧量
	sum(t.test_target) as test_target,--数量
	sum(t.rwtest_target) as rwtest_target,--任务
	concat((case when sum(t.rwtest_target)=0 then 0 else sum(t.test_target)/sum(t.rwtest_target)*100 end)::NUMERIC(10, 2), '%') as tccomplete,--完成率
	--体验上课量
	sum(t.unpayclass_target) as unpayclass_target,--数量
	sum(t.rwunpayclass_target) as rwunpayclass_target,--任务
	concat((case when sum(t.rwunpayclass_target)=0 then 0 else sum(t.unpayclass_target)/sum(t.rwunpayclass_target)*100 end)::NUMERIC(10, 2), '%') as tycomplete,--完成率
	--上课总量
	sum(t.allclass_target) as allclass_target,--数量
	sum(t.rwallclass_target) as rwallclass_target,--任务
	concat((case when sum(t.rwallclass_target)=0 then 0 else sum(t.allclass_target)/sum(t.rwallclass_target)*100 end)::NUMERIC(10, 2), '%') as skcomplete,--完成率
	--场开量
	sum(t.site_target) as site_target,--数量
	sum(t.rwsite_target) as rwsite_target,--任务
	concat((case when sum(t.rwsite_target)=0 then 0 else sum(t.site_target)/sum(t.rwsite_target)*100 end)::NUMERIC(10, 2), '%') as ckcomplete,--完成率
	--成单量
	sum(t.ordernum_target) as ordernum_target,--数量
	sum(t.rwordernum_target) as rwordernum_target,--任务
	concat((case when sum(t.rwordernum_target)=0 then 0 else sum(t.ordernum_target)/sum(t.rwordernum_target)*100 end)::NUMERIC(10, 2), '%') as cdlcomplete,--完成率
	--成单额
	sum(t.orderfee_target) as orderfee_target,--数量
	sum(t.rworderfee_target) as rworderfee_target,--任务
	concat((case when sum(t.rworderfee_target)=0 then 0 else sum(t.orderfee_target)/sum(t.rworderfee_target)*100 end)::NUMERIC(10, 2), '%') as cdecomplete--完成率
from (
select 
	case when t1.userlogin is not null and t1.userlogin != '' then t1.userlogin 
		when t2.userlogin is not null and t2.userlogin != '' then t2.userlogin 
		when t3.userlogin is not null and t3.userlogin != '' then t3.userlogin 
		when t4.userlogin is not null and t4.userlogin != '' then t4.userlogin 
		when t5.userlogin is not null and t5.userlogin != '' then t5.userlogin 
		when t6.userlogin is not null and t6.userlogin != '' then t6.userlogin 
		when t7.userlogin is not null and t7.userlogin != '' then t7.userlogin 
		when t8.userlogin is not null and t8.userlogin != '' then t8.userlogin 
		when t9.userlogin is not null and t9.userlogin != '' then t9.userlogin 
	end as userlogin,
	COALESCE(t1.custnum, 0) as custnum,--会员数量
	COALESCE(t1.guestnum, 0) as guestnum,--资源数量
	COALESCE(t2.rwfollow_target, 0) as rwfollow_target,--跟进量
	COALESCE(t2.rwtest_target, 0) as rwtest_target,--体侧量
	COALESCE(t2.rwunpayclass_target, 0) as rwunpayclass_target,--体验上课量
	COALESCE(t2.rwallclass_target, 0) as rwallclass_target,--上课总量
	COALESCE(t2.rwsite_target, 0) as rwsite_target,--场开量
	COALESCE(t2.rwordernum_target, 0) as rwordernum_target,--成单量
	COALESCE(t2.rworderfee_target, 0) as rworderfee_target,--成单额

	COALESCE(t3.follow_target, 0) as follow_target,--跟进量
	COALESCE(t4.test_target, 0) as test_target,--体侧量
	COALESCE(t5.unpayclass_target, 0) as unpayclass_target,--体验上课量
	COALESCE(t6.allclass_target, 0) as allclass_target,--上课总量
	COALESCE(t7.site_target, 0) as site_target,--场开量
	COALESCE(t8.ordernum_target, 0) as ordernum_target,--成单量
	COALESCE(t9.orderfee_target, 0) as orderfee_target--成单额

from
(SELECT
	userlogin,
	(select count(DISTINCT p.customercode) from cc_ptrest p where ptid=staff.userlogin and p.ptleftcount>0 and p.org_id = staff.org_id
	and (case when ${fld:start_date} is null then 1=1 else p.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else p.created::date<=${fld:end_date} end)) as custnum,
	(select count(DISTINCT c.customercode) from cc_card c where status!=0 and status!=6 and isgoon=0 and c.org_id = staff.org_id
	and (case when ${fld:start_date} is null then 1=1 else c.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.created::date<=${fld:end_date} end)
	and not exists(
		select 1 from cc_ptrest p where p.customercode=c.customercode
		and ptid=staff.userlogin and p.org_id = staff.org_id and p.ptleftcount>0
		and (case when ${fld:start_date} is null then 1=1 else p.created::date>=${fld:start_date} end)
		and (case when ${fld:end_date} is null then 1=1 else p.created::date<=${fld:end_date} end)
	)) as guestnum
from hr_staff staff
where staff.status = 1 and staff.org_id = ${def:org}
and exists(
	select 1 from hr_team team 
	inner join hr_team_staff hts on team.team_id = hts.team_id 
	where team.skill_scope = '1' and hts.userlogin =staff.userlogin and team.org_id = staff.org_id
)
) as t1
FULL JOIN(
	select 
		ts.userlogin,
		sum(follow_target) as rwfollow_target,
		sum(test_target) as rwtest_target,
		sum(unpayclass_target) as rwunpayclass_target,
		sum(allclass_target) as rwallclass_target,
		sum(site_target) as rwsite_target,
		sum(ordernum_target) as rwordernum_target,
		sum(orderfee_target) as rworderfee_target
	from cc_target_staff ts
	where ts.target_type = 1 and ts.org_id = ${def:org}
	and (case when ${fld:start_date} is null then 1=1 else ts.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else ts.created::date<=${fld:end_date} end)
	and exists(
	select 1 from hr_team team 
	inner join hr_team_staff hts on team.team_id = hts.team_id 
	where team.skill_scope = '1' and hts.userlogin =ts.userlogin and team.org_id = ts.org_id
	)
	GROUP BY ts.userlogin
) as t2 on t1.userlogin = t2.userlogin
FULL JOIN(
	select 
		c.createdby as userlogin,
		count(1) as follow_target
	from cc_comm c
	where c.org_id = ${def:org} and c.cust_type=2 and c.operatortype=1 and c.status!=0
	and (case when ${fld:start_date} is null then 1=1 else c.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin =c.createdby and team.org_id = c.org_id
	) GROUP BY c.createdby
) t3 on t1.userlogin = t3.userlogin
FULL JOIN(
	select 
		tr.createdby as userlogin,
		count(1) as test_target
	from cc_testresult tr
	where tr.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else tr.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else tr.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = tr.createdby and team.org_id = tr.org_id
	) GROUP BY tr.createdby
) t4 on t1.userlogin = t4.userlogin
full join (
	select 
		pr.ptid as userlogin,
		sum(case when pd.reatetype=1 then pttotalcount else 0 end) as unpayclass_target
	from cc_ptrest pr 
	left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
	where pd.reatetype=1 and pr.org_id = ${def:org}
	and (case when ${fld:start_date} is null then 1=1 else pr.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else pr.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = pr.ptid and team.org_id = pr.org_id
 		) GROUP BY pr.ptid
)as t5 on t1.userlogin = t5.userlogin
full join (
	select 
		sum(1) as allclass_target
		,p.ptid as userlogin
	from cc_ptlog p 
	inner join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
	where p.status != 0 and p.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else p.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else p.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = p.ptid and team.org_id = p.org_id
	 	)
	group by p.ptid 
)as t6 on t1.userlogin = t6.userlogin
FULL JOIN(
	select 
		c.salemember as userlogin, 
		sum(1) as site_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} and c.source='3'
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember and team.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		c.salemember1 as userlogin, 
		sum(1) as site_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} and c.source='3'
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember1 and team.org_id = c.org_id
 		)
	group by c.salemember1
) t7 on t1.userlogin = t7.userlogin
FULL JOIN(
	select 
		c.salemember as userlogin, 
		count(1) as ordernum_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember and team.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		c.salemember1 as userlogin, 
		count(1) as ordernum_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember1 and team.org_id = c.org_id
 		)
	group by c.salemember1
) t8 on t1.userlogin = t8.userlogin
FULL JOIN(
	select 
		c.salemember as userlogin, 
		sum(case when c.salemember1 is not null and c.salemember1 != '' then c.normalmoney/2.00 else c.normalmoney end) as orderfee_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember and team.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		c.salemember1 as userlogin, 
		sum(c.normalmoney/2) as orderfee_target
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '1' and hts.userlogin = c.salemember1 and team.org_id = c.org_id
 		)
	group by c.salemember1
) t9 on t1.userlogin = t9.userlogin

) t 
inner join hr_team_staff hteam on t.userlogin = hteam.userlogin
inner join hr_team team on hteam.team_id = team.team_id
where (case when ${fld:team_id} is NULL then 1=1 else team.team_id = ${fld:team_id} end) and team.org_id = ${def:org}
GROUP BY team.team_id,team.team_name


