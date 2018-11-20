select
	t.created,
	sum(t.guestnum) as guestnum,
	sum(t.dealnum) as dealnum,
	sum(t.visitnum) as visitnum,
	sum(t.commnum) as commnum
from
	(select 
			to_char(created, 'yyyy-MM') as created,
			count(1) as guestnum,
			0 as dealnum,
			0 as visitnum,
			0 as commnum
		from cc_guest 
		where org_id=${def:org} and created>=${fld:fdate} and created<=${fld:tdate}
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
		and exists(
	 			select 1 from hr_skill k 
	 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	 			where k.skill_scope in ('1','2', '4') and fk.userlogin = cc_guest.mc 
	 		)
 		group by to_char(created, 'yyyy-MM') 
	 	
	union all
		select 
			to_char(createdate, 'yyyy-MM') as created, 
			0 as guestnum,
			count(1) as dealnum,
			0 as visitnum,
			0 as commnum
 		from cc_contract c 
 		where createdate >= ${fld:fdate} AND createdate <= ${fld:tdate}
 		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = c.salemember 
 		)
		and (case when ${fld:mc} is null then 1=1 else c.salemember = ${fld:mc} end)
 		group by to_char(createdate, 'yyyy-MM') 
 		
 		union all 
 		
		select 
			to_char(createdate, 'yyyy-MM') as created, 
			0 as guestnum,
			count(1) as dealnum,
			0 as visitnum,
			0 as commnum
 		from cc_contract c 
 		where createdate >= ${fld:fdate} AND createdate <= ${fld:tdate}
 		AND contracttype = 0 AND type IN (0,5) 
		AND org_id = ${def:org} AND status >= 2
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2', '4')  and fk.userlogin = c.salemember1 
 		)
		and (case when ${fld:mc} is null then 1=1 else c.salemember1 = ${fld:mc} end)
 		group by to_char(createdate, 'yyyy-MM') 
 		
 	union all
 		
		SELECT 
			to_char(created, 'yyyy-MM') as created, 
			0 as guestnum,
			0 as dealnum,
			count(1) as visitnum,
			0 as commnum
		FROM cc_guest_visit 
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate}
		AND org_id = ${def:org} AND status != 0 
		and (case when ${fld:mc} is null then 1=1 else mc = ${fld:mc} end)
		group by to_char(created, 'yyyy-MM')
		
	union all
		select 
			to_char(created, 'yyyy-MM') as created, 
			0 as guestnum,
			0 as dealnum,
			0 as visitnum,
			count(1) as commnum
		from cc_comm
		WHERE created::date >= ${fld:fdate} AND created::date <= ${fld:tdate}
		AND org_id = ${def:org} AND status =1
		and (case when ${fld:mc} is null then 1=1 else createdby = ${fld:mc} end)
		group by to_char(created, 'yyyy-MM')
	
	) t 
	group by t.created
	order by to_char(concat(t.created, '-01')::date, 'yyyy')::integer, to_char(concat(t.created, '-01')::date, 'MM')::integer