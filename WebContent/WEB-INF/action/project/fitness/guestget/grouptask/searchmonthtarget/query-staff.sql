select 
	staff.userlogin,
	staff.name,
	(select count(1) from cc_guest
		where to_char(created::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
		and org_id = ${def:org} and status = 1 and createdby = staff.userlogin) as guestnum,
	(select ts.guest_target from cc_target_staff ts
		left join cc_target_group tg on ts.targetgroupid = tg.tuid and ts.org_id = tg.org_id
		where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
		and ts.org_id = ${def:org} and tg.target_type = 1 and ts.userlogin = staff.userlogin) as userguestnum
from hr_staff staff
left join hr_team_staff ts on staff.user_id = ts.user_id::int 
where staff.org_id = ${def:org} 
and ts.team_id = ${fld:pk_value}
and staff.status=1
order by guestnum desc
