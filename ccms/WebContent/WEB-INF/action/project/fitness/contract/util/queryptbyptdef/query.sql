select distinct s.user_id, s.userlogin, s.name, s.name_en 
from hr_staff s 
where exists(
	select 1 from hr_staff_skill sk 
	inner join hr_skill k on sk.skill_id = k.skill_id 
	where sk.user_id = s.user_id and k.skill_scope in ('1','4')
) 
and s.is_member = 0 and s.status = 1 
and s.org_id = ${def:org} 
AND (
	${fld:ptlevelcode} IS NULL OR ${fld:ptlevelcode} = '' OR EXISTS(
		SELECT 1 FROM cc_ptdef_limit t 
		WHERE t.ptdefcode =  ${fld:ptlevelcode} AND t.pt = s.userlogin 
		AND t.org_id = s.org_id
	)
) 
order by s.name_en
