select 
	string_agg(ct.code, ',') as  thecodes
from cc_guest gt
left join cc_thecontact ct on gt.code = ct.guestcode
where 
 gt.org_id = ${def:org} and 
 (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else gt.mc = '${def:user}' end)
and gt.code like concat('%', ${fld:custcode}, '%') --(
--	ct.code like concat('%', ${fld:custcode}, '%') or
--	gt.code like concat('%', ${fld:custcode}, '%') 
--)