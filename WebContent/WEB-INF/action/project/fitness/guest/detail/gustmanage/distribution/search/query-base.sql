select 
	concat('<input type="radio" class="duoxuan" name="datalist"  value="',userlogin,'" >'    )as application_id,
	name,
	(select count(1) from cc_guest guest
	where guest.mc = s.userlogin and guest.status !=0 and guest.status!=99 and guest.org_id = s.org_id) as gustnum,
	(select count(1) from cc_thecontact the
	left join cc_guest gt on the.guestcode=gt.code
	where gt.mc = s.userlogin 
	)as customernum
FROM hr_staff s 
inner join (select user_id from hr_staff_skill 
	inner join (
	select skill_id from hr_skill where 
	skill_scope in ('2', '4')) skill on skill.skill_id = hr_staff_skill.skill_id
	) hs on hs.user_id = s.user_id
WHERE s.is_member = 0 AND s.status = 1 
AND s.org_id = ${def:org}

