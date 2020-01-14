select 
	gt.code as gtcode
	,ct.code as thecode
	,gt.officename

	--,ct.code as thecode
	,ct.name as thename
	,ct.mobile
from  cc_thecontact ct
left join cc_guest gt on gt.code = ct.guestcode
where 
 gt.org_id = ${def:org} and 
 (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else gt.mc = '${def:user}' end)
${filter}