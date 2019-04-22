select userlogin as uid,name,(case when sex='0' then '女' when sex='1' then '男' else 'null' end) as sex,status from 
hr_staff where  user_id in( 
	 (select user_id from hr_staff_skill inner join(
				select skill_id from hr_skill where skill_scope in ('1', '2') and org_id = ${fld:org}
			) skill on skill.skill_id = hr_staff_skill.skill_id
		)
	
) and mobile=${fld:userCode} and org_id=${fld:org}
