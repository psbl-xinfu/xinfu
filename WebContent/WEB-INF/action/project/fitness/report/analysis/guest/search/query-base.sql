select
	(select name from hr_staff where userlogin = h.userlogin) as name,
	h.userlogin,
	sum(COALESCE(guestnum,0) )as guestnum,
	sum(COALESCE(dealnum,0) )as dealnum,--成交
	sum(COALESCE(visitnum,0) )as visitnum,
	sum(COALESCE(commnum,0) )as commnum,
	(round(sum(COALESCE(dealnum,0) )::numeric/sum(COALESCE(guestnum,0) )::numeric,2)*100)::int  as closing
from hr_staff h 
inner join (
		select 
			mc as userlogin,
			count(1) as guestnum,
			0 as dealnum,
			0 as visitnum,
			0 as commnum
		from cc_guest 
		where org_id=${def:org} and created>=${fld:listfdate} and created<=${fld:listtdate}
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		and exists(
	 			select 1 from hr_skill k 
	 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	 			where k.skill_scope in ('2', '4') and fk.userlogin = cc_guest.mc 
	 		)
	 	group by mc
	union all
		select 
			c.salemember as userlogin, 
			0 as guestnum,
			count(1) as dealnum,
			0 as visitnum,
			0 as commnum
 		from cc_contract c 
 		where createdate >= ${fld:listfdate} AND createdate <= ${fld:listtdate}
 		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = c.salemember 
 		)
		and (case when ${fld:listmc} is null then 1=1 else c.salemember = ${fld:listmc} end)
 		group by c.salemember 
 		
 		union all 
 		
		select 
			c.salemember1 as userlogin, 
			0 as guestnum,
			count(1) as dealnum,
			0 as visitnum,
			0 as commnum
 		from cc_contract c 
 		where createdate >= ${fld:listfdate} AND createdate <= ${fld:listtdate}
 		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('2', '4')  and fk.userlogin = c.salemember1 
 		)
		and (case when ${fld:listmc} is null then 1=1 else c.salemember1 = ${fld:listmc} end)
 		group by c.salemember1 
 	union all
 		
		SELECT 
			mc as userlogin, 
			0 as guestnum,
			0 as dealnum,
			count(1) as visitnum,
			0 as commnum
		FROM cc_guest_visit 
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate}
		AND org_id = ${def:org} AND status != 0 
		and (case when ${fld:listmc} is null then 1=1 else mc = ${fld:listmc} end)
		group by mc
		
 	union all
 		
		SELECT 
			createdby as userlogin, 
			0 as guestnum,
			0 as dealnum,
			0 as visitnum,
			count(1) as commnum
		FROM cc_comm 
		WHERE created::date >= ${fld:listfdate} AND created::date <= ${fld:listtdate}
		AND org_id = ${def:org} AND status = 1 
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