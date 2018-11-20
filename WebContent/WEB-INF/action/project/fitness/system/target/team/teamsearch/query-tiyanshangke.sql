select 
	count(1) as tiyanshangke
from cc_ptrest rest 
inner join cc_ptlog log on rest.code = log.ptrestcode and rest.org_id = log.org_id
inner join (select 
			staff.userlogin
		from hr_staff staff
		left join hr_team_staff ss on staff.userlogin = ss.userlogin
		where staff.org_id = ${def:org} 
		and ss.team_id = 
			(select team_id from hr_team sk left join cc_target_group tg on sk.team_id = tg.pk_value and sk.org_id = tg.org_id
				where sk.org_id = ${def:org} and sk.skill_scope = ${fld:skill_scope}
				and tg.target_type=0 and concat(tg.target_year||'-'||tg.target_month)= (select to_char(('${def:date}'::date- ('1 month')::interval), 'yyyy-MM'))
			)
		and staff.status=1) s on log.ptid = s.userlogin
where rest.org_id = ${def:org} and rest.pttype = 5 and
	 to_char(log.created::date, 'yyyy-MM') = (select to_char(('${def:date}'::date- ('1 month')::interval), 'yyyy-MM'))
