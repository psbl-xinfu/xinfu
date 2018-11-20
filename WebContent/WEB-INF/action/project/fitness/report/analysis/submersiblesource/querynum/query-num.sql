select
	t.created,
	sum(t.introducenum) as introducenum,
	sum(t.wbexpandnum) as wbexpandnum,
	sum(t.tyknum) as tyknum
from
	(
		SELECT 
			to_char(created::date, 'yyyy-MM') as created,
			count(1) as introducenum,
			0 as wbexpandnum,
			0 as tyknum
		FROM cc_guest
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(created::date, 'yyyy-MM') 
 	
 		union all
 		
		SELECT 
			to_char(created::date, 'yyyy-MM') as created,
			0 as introducenum,
			count(1) as wbexpandnum,
			0 as tyknum
		FROM cc_guest
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate} 
		AND org_id = ${def:org} AND status !=0 and (recommend is null or recommend='')
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
 		group by to_char(created::date, 'yyyy-MM') 
 		
 		union all
 		
 		select 
			to_char(el.created::date, 'yyyy-MM') as created,
			0 as introducenum,
			0 as wbexpandnum,
			count(el.*) as tyknum
		from cc_expercard_log el
		left JOIN cc_share_log sl on sl.code=el.sharecode and el.org_id = sl.org_id
		left JOIN cc_customer cust on sl.createdby=cust.code and sl.org_id = cust.org_id
		where el.org_id=${def:org} and el.status=1
		and el.created::date >= ${fld:fdate} AND el.created::date <= ${fld:tdate} 
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = cust.mc 
 		)
		and (case when ${fld:mc} is null then 1=1 else cust.mc = ${fld:mc} end)
		group by to_char(el.created::date, 'yyyy-MM') 
 		
) t 
group by t.created
order by to_char(concat(t.created, '-01')::date, 'yyyy')::integer, to_char(concat(t.created, '-01')::date, 'MM')::integer
