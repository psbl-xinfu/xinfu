select 
	pk_value,
	(select count(1) from hr_team_staff where team_id = tg.pk_value) as usernum,
	(select team_name from hr_team where team_id = tg.pk_value and org_id = ${def:org}) as name,
	sum(tg.guest_target) as guest_target,
	(select count(1) from cc_guest
		where to_char(created::date, 'yyyy-MM') = to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
		and org_id = ${def:org} and status = 1
		and createdby in (select userlogin from hr_team_staff where team_id = tg.pk_value)) as guestnum
from cc_target_group tg 
where to_char(concat(tg.target_year, '-', tg.target_month, '-01')::date, 'yyyy-MM') 
	= to_char(${fld:monthdateinfo}::date, 'yyyy-MM')
and tg.org_id = ${def:org} and tg.target_type = 1 
and (case when ${fld:team_id} is null then 1=1 else pk_value = ${fld:team_id} end)
group by pk_value