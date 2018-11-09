 AND  
 (case when exists(
	(select 1 from hr_staff where userlogin = ${fld:daochu_vc_ptid} 
		and user_id in (select user_id from hr_staff_skill where skill_id in(
			select skill_id from hr_skill where skill_scope in ('1', '2')
		))
	)
) then 1=1 else 
	(p.ptid =${fld:daochu_vc_ptid} or p.ptid in 
	(select userlogin from hr_staff where 
	 	user_id in (select user_id from hr_staff_skill where skill_id in(
			select skill_id from hr_skill where skill_scope = '1'
		))
	)) 
	end)