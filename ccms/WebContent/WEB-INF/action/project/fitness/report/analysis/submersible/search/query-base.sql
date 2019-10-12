select
	(select name from hr_staff where userlogin = h.userlogin) as name,
	h.userlogin,
	sum(msvisitnum) as msvisitnum,
	sum(khguestnum) as khguestnum,
	sum(yyvisitnum) as yyvisitnum,
	sum(followupnum) as followupnum,
	concat((case when sum(t.followupnum)=0 then 0 
		else sum(t.yyvisitnum)/sum(t.followupnum)*100 end)::NUMERIC(10, 2), '%') as yyrate
from hr_staff h 
inner join (
		SELECT 
			mc as userlogin,
			count(1) as msvisitnum,
			0 as khguestnum,
			0 as yyvisitnum,
			0 as followupnum
		FROM cc_guest_visit 
		WHERE visitdate::date >= ${fld:listfdate} AND visitdate::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status != 0 and (preparecode is null or preparecode = '')
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		group by mc
		
 		union all 
 		
		SELECT 
			mc as userlogin,
			0 as msvisitnum,
			count(1) as khguestnum,
			0 as yyvisitnum,
			0 as followupnum
		FROM cc_guest
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		group by mc
 		
		union all
		
		SELECT 
			createdby as userlogin,
			0 as msvisitnum,
			0 as khguestnum,
			count(1) as yyvisitnum,
			0 as followupnum
		FROM cc_guest_prepare
		WHERE preparedate::date >= ${fld:listfdate} AND preparedate::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status =4
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = cc_guest_prepare.createdby 
 		)
		and (case when ${fld:listmc} is null then 1=1 else createdby = ${fld:listmc} end)
		group by createdby
		
		union all
		
		SELECT 
			createdby as userlogin,
			0 as msvisitnum,
			0 as khguestnum,
			0 as yyvisitnum,
			count(1) as followupnum
		FROM cc_guest_prepare
		WHERE preparedate::date >= ${fld:listfdate} AND preparedate::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = cc_guest_prepare.createdby 
 		)
		and (case when ${fld:listmc} is null then 1=1 else createdby = ${fld:listmc} end)
		group by createdby
		
) as t on h.userlogin = t.userlogin
where h.status = 1 and h.userlogin = (case when ${fld:listmc} is null then h.userlogin else ${fld:listmc} end ) 
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope in ('2', '4') and org_id = ${def:org}
	and fk.user_id=h.user_id
)
and h.org_id = ${def:org}
group by h.userlogin