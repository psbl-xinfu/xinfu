select
	(select name from hr_staff where userlogin = h.userlogin) as name,
	h.userlogin,
	concat((case when (sum(t.msvisitnum)+sum(t.tjguestnum)+sum(t.ppvisitnum))=0 then 0 
		else (sum(t.msdealnum)+sum(t.tjdealnum)+sum(t.ppdealnum))/(sum(t.msvisitnum)+sum(t.tjguestnum)+sum(t.ppvisitnum))*100 end)::NUMERIC(10, 2), '%') as zongrate,--总成交率
	concat((case when sum(t.msvisitnum)=0 then 0 
		else sum(t.msdealnum)/sum(t.msvisitnum)*100 end)::NUMERIC(10, 2), '%') as msrate,--陌生到访成交率
	concat((case when sum(t.tjguestnum)=0 then 0 
		else sum(t.tjdealnum)/sum(t.tjguestnum)*100 end)::NUMERIC(10, 2), '%') as guestrate,--客户转介绍到访成交率
	concat((case when sum(t.ppvisitnum)=0 then 0 
		else sum(t.ppdealnum)/sum(t.ppvisitnum)*100 end)::NUMERIC(10, 2), '%') as yyrate--邀约到访成交率
from hr_staff h 
inner join (

		SELECT 
			mc as userlogin,
			count(1) as msvisitnum,
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as ppvisitnum,
			0 as ppdealnum
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
			count(1) as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as ppvisitnum,
			0 as ppdealnum
		FROM cc_guest_visit 
		WHERE visitdate::date >= ${fld:listfdate} AND visitdate::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status = 3 and (preparecode is null or preparecode = '')
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
			0 as msdealnum,
			count(1) as tjdealnum,
			0 as tjguestnum,
			0 as ppvisitnum,
			0 as ppdealnum
		FROM cc_customer 
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0
		and exists(
			select 1 from cc_guest
			where cc_customer.guestcode = code
			and created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
			AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
		)
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
			0 as msdealnum,
			0 as tjdealnum,
			count(1) as tjguestnum,
			0 as ppvisitnum,
			0 as ppdealnum
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
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			count(1) as ppvisitnum,
			0 as ppdealnum
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
			0 as msdealnum,
			0 as tjdealnum,
			0 as tjguestnum,
			0 as ppvisitnum,
			count(1) as ppdealnum
		FROM cc_customer 
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0
		and exists(
			SELECT 1 FROM cc_guest_prepare
			WHERE preparedate::date >= ${fld:listfdate} AND preparedate::date <= ${fld:listtdate} 
			AND org_id = ${def:org} AND status =4
			and cc_customer.guestcode = guestcode
		)
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
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