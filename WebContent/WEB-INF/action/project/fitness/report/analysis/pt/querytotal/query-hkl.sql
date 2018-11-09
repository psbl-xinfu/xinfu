select 
	sum(freenum)+sum(feenum) as haokelv,--当前耗课率
	sum(totalnum) as totalnum
from
(select 
	case when t1.ptid is not null and t1.ptid != '' then t1.ptid 
		when t2.userlogin is not null and t2.userlogin != '' then t2.userlogin 
	end as userlogin,
	COALESCE(t1.freenum,0) as freenum,--体验课
	COALESCE(t1.feenum,0) as feenum,--收费课
	COALESCE(t2.totalnum,0) as totalnum--总课时
from (
	select 
		sum(case when d.reatetype = 1 then 1 else 0 end) as freenum--体验课
		,sum(case when d.reatetype = 0 then 1 else 0 end) as feenum--收费课
		,p.ptid
	from cc_ptlog p 
	inner join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
	where p.status != 0 and p.org_id = ${def:org} 
	and (case when ${fld:fdate} is null then 1=1 else p.created::date>=${fld:fdate} end)
	and (case when ${fld:tdate} is null then 1=1 else p.created::date<=${fld:tdate} end)
	and exists(
	 		select 1 from hr_skill k 
	 		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	 		where k.skill_scope in ('1','4')  and fk.userlogin = p.ptid and k.org_id = p.org_id
	 	)
	group by p.ptid 
) as t1 
full join (
	select 
		sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum
		,c.salemember as userlogin
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org}  
	and (case when ${fld:fdate} is null then 1=1 else c.createdate>=${fld:fdate} end)
	and (case when ${fld:tdate} is null then 1=1 else c.createdate<=${fld:tdate} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','4')  and fk.userlogin = c.salemember and k.org_id = c.org_id
 		)
	group by c.salemember
	union all 
	select 
		sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum
		,c.salemember1 as userlogin
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:fdate} is null then 1=1 else c.createdate>=${fld:fdate} end)
	and (case when ${fld:tdate} is null then 1=1 else c.createdate<=${fld:tdate} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','4')  and fk.userlogin = c.salemember1 and k.org_id = c.org_id
 		)
	group by c.salemember1
) as t2 on t1.ptid = t2.userlogin 
) t 
