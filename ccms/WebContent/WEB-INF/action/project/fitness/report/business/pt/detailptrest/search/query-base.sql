select 
	'' as code,
	cust.name,
	cust.mobile,
	d.ptlevelname,
	0 as pttotalcount,
	0 as ptleftcount,
	0 as ptmoney,
	p.created
from cc_ptlog p 
left join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
where p.status != 0 and p.org_id = ${def:org} and d.reatetype = 1 
and (case when ${fld:startdate} is null then 1=1 else p.created::date>=${fld:startdate} end)
and (case when ${fld:enddate} is null then 1=1 else p.created::date<=${fld:enddate} end)
and (case when ${fld:skill} is null then 1=1 else p.ptid=${fld:skill} end) and ${fld:type}='1'
and exists(
 		select 1 from hr_skill k 
 		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 		where k.skill_scope = '1'  and fk.userlogin = p.ptid and k.org_id = p.org_id
 		and (case when ${fld:skill} is null then 1=1 else fk.userlogin=${fld:skill} end)
 	)

union all

select 
	'' as code,
	cust.name,
	cust.mobile,
	d.ptlevelname,
	0 as pttotalcount,
	0 as ptleftcount,
	0 as ptmoney,
	p.created
from cc_ptlog p 
left join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
left join cc_customer cust on p.customercode = cust.code and p.org_id = cust.org_id
where p.status != 0 and p.org_id = ${def:org} and d.reatetype = 0 
and (case when ${fld:startdate} is null then 1=1 else p.created::date>=${fld:startdate} end)
and (case when ${fld:enddate} is null then 1=1 else p.created::date<=${fld:enddate} end)
and (case when ${fld:skill} is null then 1=1 else p.ptid=${fld:skill} end) and (${fld:type}='2' or ${fld:type}='5')
and exists(
 		select 1 from hr_skill k 
 		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 		where k.skill_scope = '1'  and fk.userlogin = p.ptid and k.org_id = p.org_id
 		and (case when ${fld:skill} is null then 1=1 else fk.userlogin=${fld:skill} end)
 	)

union all

select
	c.code,
	cust.name,
	cust.mobile,
	pd.ptlevelname,
	pr.pttotalcount::int,
	pr.ptleftcount::int,
	pr.ptmoney,
	null as created
from cc_contract c 
left join cc_ptrest pr on pr.contractcode = c.code and pr.org_id = c.org_id
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where 1=1 and c.org_id=${def:org} and c.status>=2 and c.type = 2 and contracttype = 0
and (case when ${fld:startdate} is null then 1=1 else c.createdate>=${fld:startdate} end)
and (case when ${fld:enddate} is null then 1=1 else c.createdate<=${fld:enddate} end)
and (case when ${fld:skill} is null then 1=1 else get_arr_value(c.relatedetail,8)=${fld:skill} end)
and exists(select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '1'  and fk.userlogin = get_arr_value(c.relatedetail,8) and k.org_id = c.org_id
	and (case when ${fld:skill} is null then 1=1 else fk.userlogin=${fld:skill} end)
) and ${fld:type}='3'
and (case when (select count(1) from cc_ptrest where customercode = c.customercode and org_id = c.org_id)>1 
		then exists(select 1 from dual where c.code = 
	(select contractcode from cc_ptrest where customercode = c.customercode and org_id = c.org_id order by created asc limit 1)) else 1=1  end)

union all

select
	c.code,
	cust.name,
	cust.mobile,
	pd.ptlevelname,
	pr.pttotalcount::int,
	pr.ptleftcount::int,
	pr.ptmoney,
	null as created
from cc_contract c 
left join cc_ptrest pr on pr.contractcode = c.code and pr.org_id = c.org_id
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.org_id=${def:org} and c.status>=2 and c.type = 2 and contracttype = 0
and (case when ${fld:startdate} is null then 1=1 else c.createdate>=${fld:startdate} end)
and (case when ${fld:enddate} is null then 1=1 else c.createdate<=${fld:enddate} end)
and (case when ${fld:skill} is null then 1=1 else get_arr_value(c.relatedetail,8)=${fld:skill} end)
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '1'  and fk.userlogin = get_arr_value(c.relatedetail,8) and k.org_id = c.org_id
	 and (case when ${fld:skill} is null then 1=1 else fk.userlogin=${fld:skill} end)
) and ${fld:type}='4'
and exists(select 1 from dual where c.code != 
(select contractcode from cc_ptrest where customercode = c.customercode and org_id = c.org_id order by created asc limit 1))

union all

select 
	'' as code,
	cust.name,
	cust.mobile,
	d.ptlevelname,
	pr.pttotalcount as pttotalcount,
	pr.ptleftcount as ptleftcount,
	pr.ptmoney as ptmoney,
	pr.created
from cc_ptrest pr 
left join cc_ptdef d on d.code = pr.ptlevelcode and pr.org_id = d.org_id
left join cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
where pr.org_id = ${def:org} and pr.pttype=5
and (case when ${fld:startdate} is null then 1=1 else pr.created::date>=${fld:startdate} end)
and (case when ${fld:enddate} is null then 1=1 else pr.created::date<=${fld:enddate} end)
and (case when ${fld:skill} is null then 1=1 else pr.ptid=${fld:skill} end) and ${fld:type}='6'
and exists(
 		select 1 from hr_skill k 
 		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 		where k.skill_scope = '1'  and fk.userlogin = pr.ptid and k.org_id = pr.org_id
 		and (case when ${fld:skill} is null then 1=1 else fk.userlogin=${fld:skill} end)
 	)