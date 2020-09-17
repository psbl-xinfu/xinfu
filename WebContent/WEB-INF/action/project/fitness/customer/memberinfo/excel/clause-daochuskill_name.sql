and (
	case when exists(
		select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
		where hs.org_id = ${def:org} and hss.userlogin = '${def:user}' and skill_scope = '1'
	) 
	then EXISTS(
		SELECT 1 FROM cc_ptrest t 
		WHERE t.customercode = r.code AND t.ptleftcount > 0 AND t.pttype != 5 AND t.org_id = r.org_id AND t.ptid=${fld:daochuskill_name}
	) 
	else cust.mc = ${fld:daochuskill_name} end
)
  