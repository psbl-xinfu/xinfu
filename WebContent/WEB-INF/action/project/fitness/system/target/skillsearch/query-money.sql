select 
	sum(
	(case when (con.salemember1 is null or con.salemember1='') then con.normalmoney
		else (con.normalmoney/2) 
	end)) as normalmoney
from cc_guest g 
inner join cc_guest_visit v on g.code = v.guestcode and v.status != 0 and g.org_id = v.org_id
left join cc_contract con on v.contractcode = con.code and v.org_id = con.org_id
inner join (select 
			staff.userlogin
		from hr_staff staff
		left join hr_staff_skill ss on staff.user_id = ss.user_id
		inner join (select skill_id from hr_skill sk left join cc_target_group tg on sk.skill_id = tg.pk_value and sk.org_id = tg.org_id
				where sk.org_id = ${def:org} and sk.skill_scope = ${fld:skill_scope}
				and tg.target_type=0 and concat(tg.target_year||'-'||tg.target_month)= (select to_char(('${def:date}'::date- ('1 month')::interval), 'yyyy-MM'))
			) skill on skill.skill_id = ss.skill_id
		where staff.org_id = ${def:org} 
		and staff.status=1) s on con.salemember = s.userlogin
where g.org_id = ${def:org} 
and con.contracttype !=3 and con.status = 2 

union

select 
	sum(
	(case when (con.salemember is null or con.salemember='') then con.normalmoney
		else (con.normalmoney/2) 
	end)) as normalmoney
from cc_guest g 
inner join cc_guest_visit v on g.code = v.guestcode and v.status != 0 and g.org_id = v.org_id
left join cc_contract con on v.contractcode = con.code and v.org_id = con.org_id
inner join (select 
			staff.userlogin
		from hr_staff staff
		left join hr_staff_skill ss on staff.user_id = ss.user_id
		inner join (select skill_id from hr_skill sk left join cc_target_group tg on sk.skill_id = tg.pk_value and sk.org_id = tg.org_id
				where sk.org_id = ${def:org} and sk.skill_scope = ${fld:skill_scope}
				and tg.target_type=0 and concat(tg.target_year||'-'||tg.target_month)= (select to_char(('${def:date}'::date- ('1 month')::interval), 'yyyy-MM'))
			) skill on skill.skill_id = ss.skill_id
		where staff.org_id = ${def:org} 
		and staff.status=1) s on con.salemember1 = s.userlogin
where g.org_id = ${def:org} 
and con.contracttype !=3 and con.status = 2 