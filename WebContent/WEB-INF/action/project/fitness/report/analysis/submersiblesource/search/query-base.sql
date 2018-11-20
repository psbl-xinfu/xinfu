select
	(select name from hr_staff where userlogin = h.userlogin) as name,
	h.userlogin,
	sum(introducenum) as introducenum,
	sum(wbexpandnum) as wbexpandnum,
	sum(tyknum) as tyknum
from hr_staff h 
inner join (
		SELECT 
			mc as userlogin,
			count(1) as introducenum,
			0 as wbexpandnum,
			0 as tyknum
		FROM cc_guest
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0 and recommend is not null and recommend!=''
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		group by mc
		
		union all
		
		SELECT 
			mc as userlogin,
			0 as introducenum,
			count(1) as wbexpandnum,
			0 as tyknum
		FROM cc_guest
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate} 
		AND org_id = ${def:org} AND status !=0 and (recommend is null or recommend='')
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		group by mc
		
		union all
		
		select 
			cust.mc as userlogin,
			0 as introducenum,
			0 as wbexpandnum,
			count(el.*) as tyknum
		from cc_expercard_log el
		left JOIN cc_share_log sl on sl.code=el.sharecode and sl.org_id = el.org_id
		left JOIN cc_customer cust on sl.createdby=cust.code and sl.org_id = cust.org_id
		WHERE el.created::date >= ${fld:listfdate} AND el.created::date <= ${fld:listtdate} 
		AND el.org_id = ${def:org} AND el.status =1
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = cust.mc 
 		)
		and (case when ${fld:listmc} is null then 1=1 else cust.mc = ${fld:listmc} end)
		GROUP BY cust.mc
		
) as t on h.userlogin = t.userlogin
where h.status = 1 and h.userlogin = (case when ${fld:listmc} is null then h.userlogin else ${fld:listmc} end ) 
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope in ('1','2', '4') and org_id = ${def:org}
	and fk.user_id=h.user_id
)
and h.org_id = ${def:org}
group by h.userlogin