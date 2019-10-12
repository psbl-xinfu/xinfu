select
	t.created,
	sum(t.msvisitnum) as msvisitnum,
	sum(t.msdealnum) as msdealnum,
	sum(t.tjdealnum) as tjdealnum,
	sum(t.tjguestnum) as tjguestnum,
	sum(t.yyvisitnum) as yyvisitnum,
	sum(t.yydealnum) as yydealnum
from
	(SELECT 
			to_char(visitdate::date, 'yyyy-MM') as created,
			count(1) as msvisitnum,
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as yyvisitnum,
			0 as yydealnum
		FROM cc_guest_visit 
		WHERE visitdate::date >= ${fld:fdate} AND visitdate::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status != 0 and (preparecode is null or preparecode = '')
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(visitdate::date, 'yyyy-MM') 
 		
	union all
		SELECT 
			to_char(visitdate::date, 'yyyy-MM') as created,
			0 as msvisitnum,
			count(1) as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as yyvisitnum,
			0 as yydealnum
		FROM cc_guest_visit 
		WHERE visitdate::date >= ${fld:fdate} AND visitdate::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status = 3 and (preparecode is null or preparecode = '')
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(visitdate::date, 'yyyy-MM') 
 		
 		union all 
 		
		SELECT 
			to_char(created::date, 'yyyy-MM') as created,
			0 as msvisitnum,
			0 as msdealnum,
			count(1) as tjdealnum,
			0 as tjguestnum,
			0 as yyvisitnum,
			0 as yydealnum
		FROM cc_customer 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status !=0
		and exists(
			select 1 from cc_guest
			where cc_customer.guestcode = code
			and created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
			AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
		)
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(created::date, 'yyyy-MM') 
		
 		union all 
 		
		SELECT 
			to_char(created::date, 'yyyy-MM') as created,
			0 as msvisitnum,
			0 as msdealnum,
			0 as tjdealnum,
			count(1) as tjguestnum,
			0 as yyvisitnum,
			0 as yydealnum
		FROM cc_guest
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(created::date, 'yyyy-MM') 
 	
		union all
		
		SELECT 
			to_char(preparedate::date, 'yyyy-MM') as created,
			0 as msvisitnum,
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			count(1) as yyvisitnum,
			0 as yydealnum
		FROM cc_guest_prepare
		WHERE preparedate::date >= ${fld:fdate} AND preparedate::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status =4
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = cc_guest_prepare.createdby 
 		)
		and (case when ${fld:mc} is null then 1=1 else createdby = ${fld:mc} end)
 		group by to_char(preparedate::date, 'yyyy-MM') 
		
 		union all 
 		
		SELECT 
			to_char(created::date, 'yyyy-MM') as created,
			0 as msvisitnum,
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as yyvisitnum,
			count(1) as yydealnum
		FROM cc_customer 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status !=0
		and exists(
			SELECT 1 FROM cc_guest_prepare
			WHERE preparedate::date >= ${fld:fdate} AND preparedate::date <= ${fld:tdate} 
			AND org_id = ${def:org} AND status =4
			and cc_customer.guestcode = guestcode
		)
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(created::date, 'yyyy-MM') 
 		
) t 
group by t.created
order by to_char(concat(t.created, '-01')::date, 'yyyy')::integer, to_char(concat(t.created, '-01')::date, 'MM')::integer
