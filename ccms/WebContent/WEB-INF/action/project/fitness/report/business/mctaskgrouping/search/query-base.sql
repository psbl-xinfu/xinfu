select 	
	team.team_id,
	team.team_name as staff_name,
	sum(t.custnum) as custnum,--会员数量
	sum(t.guestnum) as guestnum,--资源数量
	--资源获取量
	sum(t.guest_target) as guest_target,--数量
	sum(t.rwguest_target) as rwguest_target,--任务
	concat((case when sum(t.rwguest_target)=0 then 0 else sum(t.guest_target)/sum(t.rwguest_target)*100 end)::NUMERIC(10, 2), '%') as zycomplete,--完成率
	--跟进量
	sum(t.follow_target) as follow_target,--数量
	sum(t.rwfollow_target) as rwfollow_target,--任务
	concat((case when sum(t.rwfollow_target)=0 then 0 else sum(t.follow_target)/sum(t.rwfollow_target)*100 end)::NUMERIC(10, 2), '%') as gjcomplete,--完成率
	--回访量
	sum(t.call_target) as call_target,--数量
	sum(t.rwcall_target) as rwcall_target,--任务
	concat((case when sum(t.rwcall_target)=0 then 0 else sum(t.call_target)/sum(t.rwcall_target)*100 end)::NUMERIC(10, 2), '%') as hfcomplete,--完成率
	--预约量
	sum(t.prepare_target) as prepare_target,--数量
	sum(t.rwprepare_target) as rwprepare_target,--任务
	concat((case when sum(t.rwprepare_target)=0 then 0 else sum(t.prepare_target)/sum(t.rwprepare_target)*100 end)::NUMERIC(10, 2), '%') as yycomplete,--完成率
	--到访量
	sum(t.visit_target) as visit_target,--数量
	sum(t.rwvisit_target) as rwvisit_target,--任务
	concat((case when sum(t.rwvisit_target)=0 then 0 else sum(t.visit_target)/sum(t.rwvisit_target)*100 end)::NUMERIC(10, 2), '%') as dfcomplete,--完成率
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
	COALESCE(t2.rwguest_target, 0) as rwguest_target,--资源获取量
	COALESCE(t2.rwfollow_target, 0) as rwfollow_target,--跟进量
	COALESCE(t2.rwcall_target, 0) as rwcall_target,--回访量
	COALESCE(t2.rwprepare_target, 0) as rwprepare_target,--预约量
	COALESCE(t2.rwvisit_target, 0) as rwvisit_target,--到访量
	COALESCE(t2.rwordernum_target, 0) as rwordernum_target,--成单量
	COALESCE(t2.rworderfee_target, 0) as rworderfee_target,--成单额

	COALESCE(t3.guest_target, 0) as guest_target,--资源获取量
	COALESCE(t4.follow_target, 0) as follow_target,--跟进量
	COALESCE(t5.call_target, 0) as call_target,--回访量
	COALESCE(t6.prepare_target, 0) as prepare_target,--预约量
	COALESCE(t7.visit_target, 0) as visit_target,--到访量
	COALESCE(t8.ordernum_target, 0) as ordernum_target,--成单量
	COALESCE(t9.orderfee_target, 0) as orderfee_target--成单额
from
(select 
	s.userlogin,
	(select count(1) from cc_guest guest
		where guest.mc = s.userlogin and guest.status !=0 and guest.status!=99 and guest.org_id = ${def:org}
		and (case when ${fld:start_date} is null then 1=1 else guest.created::date>=${fld:start_date} end)
		and (case when ${fld:end_date} is null then 1=1 else guest.created::date<=${fld:end_date} end)
	) as guestnum,
	(select count(1) from cc_customer cust
		where cust.mc = s.userlogin and cust.status != 0 
		and exists(select 1 from cc_card card where card.customercode = cust.code 
			and card.org_id = cust.org_id and card.status!=0 and card.status!=6 
		) and cust.org_id = ${def:org}
		and (case when ${fld:start_date} is null then 1=1 else cust.created::date>=${fld:start_date} end)
		and (case when ${fld:end_date} is null then 1=1 else cust.created::date<=${fld:end_date} end)
	) as custnum
FROM hr_staff s 
inner join (select user_id from hr_team_staff 
	inner join (
	select team_id from hr_team where org_id = ${def:org} and
		skill_scope = '2') team on team.team_id = hr_team_staff.team_id
	) tm on tm.user_id::int = s.user_id
WHERE s.is_member = 0 AND s.status = 1
AND s.org_id = ${def:org}
GROUP BY s.userlogin
) as t1
FULL JOIN(
	select 
		ts.userlogin,
		sum(guest_target) as rwguest_target,
		sum(follow_target) as rwfollow_target,
		sum(call_target) as rwcall_target,
		sum(prepare_target) as rwprepare_target,
		sum(visit_target) as rwvisit_target,
		sum(ordernum_target) as rwordernum_target,
		sum(orderfee_target) as rworderfee_target
	from cc_target_staff ts
	where ts.target_type = 1 and ts.org_id = ${def:org}
	and (case when ${fld:start_date} is null then 1=1 else ts.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else ts.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = ts.userlogin and team.org_id = ts.org_id
	)
	GROUP BY ts.userlogin
) as t2 on t1.userlogin = t2.userlogin
FULL JOIN(
	select 
		g.initmc as userlogin,
		count(1) as guest_target
	from cc_guest g
	where org_id = ${def:org}
	and (case when ${fld:start_date} is null then 1=1 else g.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else g.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = g.initmc and team.org_id = g.org_id
	) GROUP BY g.initmc
) t3 on t1.userlogin = t3.userlogin
FULL JOIN(
	select 
		c.createdby as userlogin,
		count(1) as follow_target
	from cc_comm c
	where c.org_id = ${def:org} and c.cust_type=0 and c.operatortype=0 and c.status!=0
	and (case when ${fld:start_date} is null then 1=1 else c.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.createdby and team.org_id = c.org_id
	) GROUP BY c.createdby
) t4 on t1.userlogin = t4.userlogin
FULL JOIN(
	select 
		c.createdby as userlogin,
		count(1) as call_target
	from cc_comm c
	where c.org_id = ${def:org} and c.cust_type=1 and c.operatortype=0 and c.status!=0
	and (case when ${fld:start_date} is null then 1=1 else c.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.createdby and team.org_id = c.org_id
	) GROUP BY c.createdby
) t5 on t1.userlogin = t5.userlogin
FULL JOIN(
	select 
		gp.createdby as userlogin,
		count(1) as prepare_target
	from cc_guest_prepare gp
	where gp.org_id = ${def:org} and gp.status!=0
	and (case when ${fld:start_date} is null then 1=1 else gp.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else gp.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = gp.createdby and team.org_id = gp.org_id
	) GROUP BY gp.createdby
) t6 on t1.userlogin = t6.userlogin
FULL JOIN(
	select 
		gv.mc as userlogin,
		count(1) as visit_target
	from cc_guest_visit gv
	where gv.org_id = ${def:org} and gv.status!=0
	and (case when ${fld:start_date} is null then 1=1 else gv.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else gv.created::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = gv.mc and team.org_id = gv.org_id
	) GROUP BY gv.mc
) t7 on t1.userlogin = t7.userlogin
FULL JOIN(
	select 
	c.salemember as userlogin, 
	count(1) as ordernum_target
	from cc_contract c 
	where c.contracttype = 0 and c.type in (0, 5, 7, 9, 11) and c.status >= 2 and c.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.salemember and team.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		c.salemember1 as userlogin, 
		count(1) as ordernum_target
	from cc_contract c 
	where c.contracttype = 0 and c.type in (0, 5, 7, 9, 11) and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.salemember1 and team.org_id = c.org_id
 		)
	group by c.salemember1
) t8 on t1.userlogin = t8.userlogin
FULL JOIN(
	select 
	c.salemember as userlogin, 
	sum(case when c.salemember1 is not null and c.salemember1 != '' then c.normalmoney/2.00 else c.normalmoney end) as orderfee_target
	from cc_contract c 
	where c.contracttype = 0 and c.type in (0, 5, 7, 9, 11) and c.status >= 2 and c.org_id = ${def:org} 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.salemember and team.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		c.salemember1 as userlogin, 
		sum(c.normalmoney/2) as orderfee_target
	from cc_contract c 
	where c.contracttype = 0 and c.type in (0, 5, 7, 9, 11) and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate::date<=${fld:end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '2' and hts.userlogin = c.salemember1 and team.org_id = c.org_id
 		)
	group by c.salemember1
) t9 on t1.userlogin = t9.userlogin
) t 
inner join hr_team_staff hteam on t.userlogin = hteam.userlogin
inner join hr_team team on hteam.team_id = team.team_id
where (case when ${fld:team_id} is NULL then 1=1 else team.team_id = ${fld:team_id} end) and team.org_id = ${def:org}
GROUP BY team.team_id,team.team_name


