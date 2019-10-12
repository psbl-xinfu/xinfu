select
	(select count(1) from cc_contract c where  c.org_id=${def:org}
	and (c.type=0 or c.type = 5) 
	and
	(
	contracttype=0
	or
	contracttype=3
	) 
	and c.status != 0 
	AND 
		 createdate <= ${fld:s_end_date}
	AND
		createdate >= ${fld:s_start_date}
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
				where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
				and hss.userlogin = '${def:user}' and hs.data_limit = 1)
				then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as cardnum,
	
	(select count(1)  from cc_contract c where  c.org_id=${def:org}
	and c.contracttype in (1,2) 	and c.status != 0
		AND 
		 createdate <= ${fld:s_end_date}
	AND
		createdate >= ${fld:s_start_date}
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as upgradenum,
	
	(select count(1)  from cc_contract c where  c.org_id=${def:org}
	and c.type =2
	and
	(
	contracttype=0
	or
	contracttype=3
	)
	and c.status != 0 
	AND 
		 createdate <= ${fld:s_end_date}
	AND
		createdate >= ${fld:s_start_date}
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}')) 
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as ptnum,

	(select count(1) from cc_contract c where  c.org_id=${def:org}
		and c.type=4
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		and c.status!=0
		AND 
		 createdate <= ${fld:s_end_date}
		AND
		createdate >= ${fld:s_start_date}
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as retreatnum,
	
	(select count(1) from cc_contract c where  c.org_id=${def:org}
	and 
	(c.type = 7 OR c.type = 9 OR c.type = 11)
		AND 
		 createdate <= ${fld:s_end_date}
		AND
		createdate >= ${fld:s_start_date}
		and c.status!=0
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as continuenum,

	(select count(1)  from cc_contract c where  c.org_id=${def:org}	
		and c.type=10
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		AND 
		 createdate <= ${fld:s_end_date}
		AND
		createdate >= ${fld:s_start_date}
		and c.status != 0 
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
	) as turnnum,
		
	(select count(1) from cc_contract c where  c.org_id=${def:org}
		and
		(
		c.type=1
		or
		c.type=12
		)
		and
		(
		contracttype=0
		or
		contracttype=3
		)
		and c.status!=0
		AND 
		 createdate <= ${fld:s_end_date}
		AND
		createdate >= ${fld:s_start_date}
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
		)as rentnum
from dual