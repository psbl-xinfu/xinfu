select 
	ROW_NUMBER() OVER()as show,
	(select name from hr_staff where userlogin = t.userlogin and org_id =${def:org}) as staff_name,
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
 		and (case when ${fld:daochu_skill_name} is null then 1=1 else f.followstaff=${fld:daochu_skill_name} end)
	) as kefucount
from hr_staff staff
where staff.status = 1 and staff.org_id = ${def:org}
 	and (case when ${fld:daochu_skill_name} is null then 1=1 else staff.userlogin=${fld:daochu_skill_name} end)
	and exists(
		select 1 from hr_skill k 
		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
		where k.skill_scope in ('0')  and fk.userlogin =staff.userlogin and k.org_id = staff.org_id
	)
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
 		and (case when ${fld:daochu_skill_name} is null then 1=1 else ts.userlogin=${fld:daochu_skill_name} end)
	and exists(
		select 1 from hr_skill k 
		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
		where k.skill_scope in ('0')  and fk.userlogin = ts.userlogin and k.org_id = ts.org_id
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
 		and (case when ${fld:daochu_skill_name} is null then 1=1 else rl.followby=${fld:daochu_skill_name} end)
	and exists(
		select 1 from hr_skill k 
		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
		where k.skill_scope in ('0')  and fk.userlogin = rl.followby and k.org_id = rl.org_id
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
 		and (case when ${fld:daochu_skill_name} is null then 1=1 else rl.followby=${fld:daochu_skill_name} end)
	and exists(
		select 1 from hr_skill k 
		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
		where k.skill_scope in ('0')  and fk.userlogin = rl.followby and k.org_id = rl.org_id
	)
	GROUP BY rl.followby
) as t4 on t1.userlogin = t4.userlogin
) t GROUP BY userlogin


