select
	(select name from hr_staff where userlogin = h.userlogin) as name,
	h.userlogin
	,sum(COALESCE(cardnum,0) )as cardnum
	,sum(COALESCE(cardfee,0) )as cardfee
	,sum(COALESCE(ptnum,0)) as ptnum
	,sum(COALESCE(ptfee,0) )as ptfee
	,sum(COALESCE(xunum,0) )as xunum
	,sum(COALESCE(xufee,0) )as xufee
	,sum(COALESCE(upnum,0) )as upnum
	,sum(COALESCE(upfee,0) )as upfee
	,sum(COALESCE(cardnum,0) +COALESCE(ptnum,0) +COALESCE(xunum,0) +COALESCE(upnum,0) )as zongnum
	,sum(COALESCE(cardfee,0) +COALESCE(ptfee,0) +COALESCE(xufee,0) +COALESCE(upnum,0) )as zongprice
from hr_staff h 
inner join (
	select c.salemember as userlogin, count(1) as cardnum, 
 			sum(case when c.salemember1 is not null and c.salemember1 != '' then  COALESCE(c.normalmoney/2,0.00)   else COALESCE(c.factmoney,0.00)  end) as cardfee,
 			0 as ptnum,
 			0 as ptfee,
 			0 as upnum,
 			0 as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 2 or c.contracttype = 3) and (c.type=0 or c.type=5) 
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember 
 		)
 		and  salemember=(case when  ${fld:s_skill_name} is null  then salemember else ${fld:s_skill_name} end )
 		group by c.salemember 
 		
 		union all 
 		
 		select c.salemember1 as userlogin, count(1) as cardnum, sum(COALESCE(c.normalmoney/2,0.00)) as cardfee,
 			0 as ptnum,
 			0 as ptfee,
 			0 as upnum,
 			0 as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 2 or c.contracttype = 3) and (c.type=0 or c.type=5) and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember1 
 		)
 		and  salemember1=(case when  ${fld:s_skill_name} is null  then salemember1 else ${fld:s_skill_name} end )
 		and salemember1 is not null
 		group by c.salemember1 
union all
	select c.salemember as userlogin, 
			0 as cardnum,
			0 as cardfee,
			count(1) as ptnum, 
			sum(case when c.salemember1 is not null and c.salemember1 != '' then COALESCE(c.normalmoney/2,0.00)  else COALESCE(c.normalmoney,0.00)  end) as ptfee,
 			0 as upnum,
 			0 as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and c.contracttype = 0 and c.type=2 
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember 
 		)
 		and  salemember=(case when  ${fld:s_skill_name} is null  then salemember else ${fld:s_skill_name} end )
 		group by c.salemember 
 		
 		union all 
 		
 		select c.salemember1 as userlogin, 
			0 as cardnum,
			0 as cardfee,
 			count(1) as ptnum, 
 			sum(COALESCE(c.normalmoney/2,0.00) ) as ptfee,
 			0 as upnum,
 			0 as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and c.contracttype = 0 and c.type=2  and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember1 
 		)
 		and  salemember1=(case when  ${fld:s_skill_name} is null  then salemember1 else ${fld:s_skill_name} end )
 		and salemember1 is not null
 		group by c.salemember1 
union all
	select c.salemember as userlogin, 
			0 as cardnum,
			0 as cardfee,
 			0 as ptnum,
 			0 as ptfee,
			count(1) as upnum, 
			sum(case when c.salemember1 is not null and c.salemember1 != '' then COALESCE(c.normalmoney/2,0.00)  else COALESCE(c.normalmoney,0.00)  end) as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and (c.type=1 or  c.type=12)
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember 
 		)
 		and  salemember=(case when  ${fld:s_skill_name} is null  then salemember else ${fld:s_skill_name} end )
 		group by c.salemember 
 		
 		union all 
 		
 		select c.salemember1 as userlogin, 
			0 as cardnum,
			0 as cardfee,
 			0 as ptnum,
 			0 as ptfee,
 			count(1) as upnum, 
 			sum(COALESCE(c.normalmoney/2,0.00) ) as upfee,
 			0 as xunum,
 			0 as xufee
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and (c.type=1 or  c.type=12)  and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember1 
 		)
 		and  salemember1=(case when  ${fld:s_skill_name} is null  then salemember1 else ${fld:s_skill_name} end )
 		and salemember1 is not null
 		group by c.salemember1 
union all
	select c.salemember as userlogin,
			0 as cardnum,
			0 as cardfee,
 			0 as ptnum,
 			0 as ptfee,
 			0 as upnum,
 			0 as upfee,
			count(1) as xunum, 
			sum(case when c.salemember1 is not null and c.salemember1 != '' then COALESCE(c.normalmoney/2,0.00)  else COALESCE(c.normalmoney,0.00)  end) as xufee 
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and(c.type=7 or   c.type=9 or c.type=11)
 		and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember 
 		)
 		and  salemember=(case when  ${fld:s_skill_name} is null  then salemember else ${fld:s_skill_name} end )
 		group by c.salemember 
 		
 		union all 
 		
 		select c.salemember1 as userlogin, 
			0 as cardnum,
			0 as cardfee,
 			0 as ptnum,
 			0 as ptfee,
 			0 as upnum,
 			0 as upfee,
 			count(1) as xunum, 
 			sum(COALESCE(c.normalmoney/2,0.00) ) as xufee 
 		from cc_contract c 
 		where c.createdate >=  ${fld:s_start_date} and c.createdate <=  ${fld:s_end_date}
 		and c.org_id=${def:org} and c.status>=2 and(c.type=7 or   c.type=9 or c.type=11)   and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope in ('1','2') and fk.userlogin = c.salemember1 
 		)
 		and  salemember1=(case when  ${fld:s_skill_name} is null  then salemember1 else ${fld:s_skill_name} end )
 		and salemember1 is not null
 		group by c.salemember1 
) as t on h.userlogin = t.userlogin
where h.status = 1 and h.userlogin = (case when ${fld:s_skill_name} is null then h.userlogin else ${fld:s_skill_name} end ) 
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope in ('1','2') and org_id = ${def:org}
	and fk.user_id=h.user_id
)
and h.org_id = ${def:org}
group by h.userlogin
order by zongnum desc 