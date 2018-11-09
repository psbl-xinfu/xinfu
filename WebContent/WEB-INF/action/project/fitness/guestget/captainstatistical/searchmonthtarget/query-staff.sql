select 
	staff.userlogin,
	staff.name,
	(select count(1) from cc_guest
		where to_char(created::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
		and org_id = ${def:org} and status = 1 and createdby = staff.userlogin) as guestnum,
	(select ts.guest_target from cc_target_staff ts
		left join cc_target_group tg on ts.targetgroupid = tg.tuid and ts.org_id = tg.org_id
		where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
		and ts.org_id = ${def:org} and tg.target_type = 1 and ts.userlogin = staff.userlogin) as userguestnum,
		
	concat(ht.team_name, (case when (select user_id from hr_staff 
		where userlogin = staff.userlogin and org_id = ${def:org})=ht.leader_id::int then '组长' else '组员' end)) as team_name
from hr_staff staff
inner join hr_team_staff ts on staff.user_id = ts.user_id::int 
inner join hr_team ht on ts.team_id = ht.team_id and ht.org_id = ${def:org}
where staff.org_id = ${def:org} 
and (case when ${fld:pk_value} is null then 1=1 else ts.team_id::varchar in (select regexp_split_to_table(${fld:pk_value},',')) end)
and staff.status=1
and staff.name like concat('%', ${fld:staffname},'%')
order by guestnum desc
