select 
	ROW_NUMBER() OVER()as show,
	team.team_id,
	team.team_name as staff_name,
	sum(t.kefucount) as kefucount,--分配客诉总量
	
	--回访量
	(sum(t.call_mc_target)+sum(call_pt_target)) as call_target,--数量
	sum(t.rwcall_target) as rwcall_target,--任务
	concat((case when sum(t.rwcall_target)=0 then 0 else (sum(t.call_mc_target)+sum(call_pt_target))/sum(t.rwcall_target)*100 end)::NUMERIC(10, 2), '%') as hfcomplete,--完成率
	--回访预约会籍量
	sum(t.call_mc_target) as call_mc_target,--数量
	sum(t.rwcall_mc_target) as rwcall_mc_target,--任务
	concat((case when sum(t.rwcall_mc_target)=0 then 0 else sum(t.call_mc_target)/sum(t.rwcall_mc_target)*100 end)::NUMERIC(10, 2), '%') as hfhjcomplete,--完成率
	--回访预约私教量
	sum(t.call_pt_target) as call_pt_target,--数量
	sum(t.rwcall_pt_target) as rwcall_pt_target,--任务
	concat((case when sum(t.rwcall_pt_target)=0 then 0 else sum(t.call_pt_target)/sum(t.rwcall_pt_target)*100 end)::NUMERIC(10, 2), '%') as hfsjcomplete--完成率
from (
select 
	case when t1.userlogin is not null and t1.userlogin != '' then t1.userlogin 
		when t2.userlogin is not null and t2.userlogin != '' then t2.userlogin 
		when t3.userlogin is not null and t3.userlogin != '' then t3.userlogin 
		when t4.userlogin is not null and t4.userlogin != '' then t4.userlogin 
	end as userlogin,
	COALESCE(t1.kefucount, 0) as kefucount,--分配客诉总量

	COALESCE(t2.rwcall_target, 0) as rwcall_target,--回访量
	COALESCE(t2.rwcall_mc_target, 0) as rwcall_mc_target,--回访预约会籍量
	COALESCE(t2.rwcall_pt_target, 0) as rwcall_pt_target,--回访预约私教量


	COALESCE(t3.call_mc_target, 0) as call_mc_target,--回访预约会籍量
	COALESCE(t4.call_pt_target, 0) as call_pt_target--回访预约私教量

from
(SELECT
	userlogin,
	(select count(1) from cc_feedback_follow f 
		where f.followstaff = staff.userlogin and f.org_id = staff.org_id
		and (case when ${fld:daochu_start_date} is null then 1=1 else f.created::date>=${fld:daochu_start_date} end)
		and (case when ${fld:daochu_end_date} is null then 1=1 else f.created::date<=${fld:daochu_end_date} end)
	) as kefucount
from hr_staff staff
inner join (select user_id from hr_team_staff 
	inner join (
	select team_id from hr_team where org_id = ${def:org} and
		skill_scope = '0') team on team.team_id = hr_team_staff.team_id
	) tm on tm.user_id::int = staff.user_id
where staff.status = 1 and staff.org_id = ${def:org}
) as t1
FULL JOIN(
	select 
		ts.userlogin,
		sum(call_target) as rwcall_target,
		sum(call_mc_target) as rwcall_mc_target,
		sum(call_pt_target) as rwcall_pt_target
	from cc_target_staff ts
	where ts.target_type = 0 and ts.org_id = ${def:org}
		and (case when ${fld:daochu_start_date} is null then 1=1 else ts.created::date>=${fld:daochu_start_date} end)
		and (case when ${fld:daochu_end_date} is null then 1=1 else ts.created::date<=${fld:daochu_end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '0' and hts.userlogin = ts.userlogin and team.org_id = ts.org_id
	)
	GROUP BY ts.userlogin
) as t2 on t1.userlogin = t2.userlogin
FULL JOIN(
	select 
		rl.followby as userlogin,
		count(1) as call_mc_target
	from cc_return_log rl
	where rl.status != 0 and rl.org_id = ${def:org} and (rl.datatype=0 or rl.datatype=1)
		and (case when ${fld:daochu_start_date} is null then 1=1 else rl.created::date>=${fld:daochu_start_date} end)
		and (case when ${fld:daochu_end_date} is null then 1=1 else rl.created::date<=${fld:daochu_end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '0' and hts.userlogin = rl.followby and team.org_id = rl.org_id
	)
	GROUP BY rl.followby
) as t3 on t1.userlogin = t3.userlogin
FULL JOIN(
	select 
		rl.followby as userlogin,
		count(1) as call_pt_target
	from cc_return_log rl
	where rl.status != 0 and rl.org_id = ${def:org} and rl.datatype=2
		and (case when ${fld:daochu_start_date} is null then 1=1 else rl.created::date>=${fld:daochu_start_date} end)
		and (case when ${fld:daochu_end_date} is null then 1=1 else rl.created::date<=${fld:daochu_end_date} end)
	and exists(
		select 1 from hr_team team 
		inner join hr_team_staff hts on team.team_id = hts.team_id 
		where team.skill_scope = '0' and hts.userlogin = rl.followby and team.org_id = rl.org_id
	)
	GROUP BY rl.followby
) as t4 on t1.userlogin = t4.userlogin
) t 
inner join hr_team_staff hteam on t.userlogin = hteam.userlogin
inner join hr_team team on hteam.team_id = team.team_id
where (case when ${fld:daochu_team_id} is NULL then 1=1 else team.team_id = ${fld:daochu_team_id} end) and team.org_id = ${def:org}
GROUP BY team.team_id,team.team_name





