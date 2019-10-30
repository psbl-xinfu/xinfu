select 
	concat('<input type="radio" class="duoxuan" name="datalist"  value="',userlogin,'" >'    )as application_id,
	name,
	(select count(1) from cc_guest guest
	where guest.mc = s.userlogin and guest.status !=0 and guest.status!=99 and guest.org_id = s.org_id) as gustnum,
	(select count(1) from cc_customer cust
	where cust.mc = s.userlogin and cust.status != 0 and
		 exists(
			select 1 from cc_card card where card.customercode = cust.code 
			and card.org_id = cust.org_id and card.status!=0 and card.status!=6 
		) and cust.org_id = s.org_id)as customernum
FROM hr_staff s 
inner join (select user_id from hr_staff_skill 
	inner join (
	select skill_id from hr_skill where 
	skill_scope in ('2', '4')) skill on skill.skill_id = hr_staff_skill.skill_id
	) hs on hs.user_id = s.user_id
WHERE s.is_member = 0 AND s.status = 1 
AND s.org_id = ${def:org}

union

select 
	concat('<input type="radio" class="duoxuan" name="datalist"  value="',userlogin,'" >'    )as application_id,
	(select name from hr_staff where userlogin = s.userlogin) as name,
	(select count(1) from cc_guest guest
	where guest.mc = s.userlogin and guest.status !=0 and guest.status!=99 and guest.org_id = s.org_id) as gustnum,
	(select count(1) from cc_customer cust
	where cust.mc = s.userlogin and cust.status != 0 and
		 exists(
			select 1 from cc_card card where card.customercode = cust.code 
			and card.org_id = cust.org_id and card.status!=0 and card.status!=6 
		) and cust.org_id = s.org_id)as customernum
from hr_staff_org s
where s.org_id = ${def:org} and s.userlogin = '${def:user}'
and exists(
		select 1 from hr_staff_skill sk 
		inner join hr_skill k on sk.skill_id = k.skill_id 
		where sk.user_id = s.user_id and k.skill_scope in ('2', '4')
	) 

