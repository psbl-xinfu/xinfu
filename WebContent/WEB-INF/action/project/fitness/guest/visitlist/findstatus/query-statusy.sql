select
	count(code) as statusy
from (
	-- 正常预约、到店、签署合同
	select 	
		g.code
	from cc_guest g 
	inner join cc_guest_prepare p on g.code = p.guestcode and p.status != 0 and g.org_id = p.org_id
	left join cc_guest_visit v on p.code = v.preparecode and v.status != 0 and v.org_id = p.org_id
	left join cc_contract c on c.code = v.code and c.status != 0 and c.org_id = v.org_id
	left join cc_customer r on r.code = c.guestcode and r.org_id = c.org_id 
	where 
		(case when ${fld:cust_all} is null then (p.preparedate >= ${fld:start_date} and p.preparedate <= ${fld:end_date}) else 1=1 end)
		and g.org_id = ${def:org}
		and p.status = 1
		and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
		and (case when ${fld:mc} is null then 1=1 else p.createdby = ${fld:mc} end)
		and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
					where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
					and hss.userlogin = '${def:user}' and hs.data_limit = 1)
					then 1=1 else p.createdby = '${def:user}' end)
		
	union 
	-- 无预约到店 
	select 
		g.code
	from cc_guest g 
	inner join cc_guest_visit v on g.code = v.guestcode and v.status != 0 and g.org_id = v.org_id
	left join cc_contract c on c.code = v.code and c.status != 0 and c.org_id = v.org_id
	left join cc_customer r on r.code = c.guestcode and r.org_id = c.org_id 
	where (v.preparecode is null or v.preparecode = '') and g.org_id = ${def:org}
		and (case when ${fld:cust_all} is null then (v.visitdate >= ${fld:start_date} and v.visitdate <= ${fld:end_date}) else 1=1 end)
		and (case when ${fld:mc} is null then 1=1 else v.mc = ${fld:mc} end) 
		and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
		and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
					where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
					and hss.userlogin = '${def:user}' and hs.data_limit = 1)
					then 1=1 else g.mc = '${def:user}' end)
	union 
	-- 直接签署合同
	select 
		c.code
	from cc_contract c 
	inner join cc_customer m on m.code=c.guestcode and c.org_id = m.org_id
	inner join cc_guest g on g.code=m.guestcode and g.org_id = m.org_id
	and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
	where (case when ${fld:cust_all} is null then (c.createdate >= ${fld:start_date} and c.createdate <= ${fld:end_date}) else 1=1 end)
	and c.contracttype = 0 and c.type in (0,5) and c.org_id = ${def:org} 
	and m.status != 0 and c.org_id = ${def:org} and not exists(
		select 1 from cc_guest_visit v where c.code = v.contractcode
	)
	and exists(select 1 from cc_guest_prepare p where p.guestcode = g.code 
	and (case when ${fld:mc} is null then 1=1 else p.createdby = ${fld:mc} end)
	and p.status = 1)
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
) tp
