SELECT 
	p.preparedate as c_date
	,c.name as vc_name
	,p.status as i_status
	,p.starttime
	,p.endtime
FROM cc_ptprepare p 
inner JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id
inner JOIN cc_ptrest r ON p.ptrestcode = r.code and p.org_id = r.org_id
inner join cc_ptdef pd on pd.code = r.ptlevelcode and pd.org_id = r.org_id
WHERE 1=1 
and (case when ${fld:ptlevelcode} is not null then r.ptlevelcode = ${fld:ptlevelcode} else 1=1 end)
AND p.org_id = ${def:org} and p.status!=4
--类别：0前台 1PT 2MC 3水吧 4系统管理员 5财务 6人力 7运营 8团操教练';
and 
(case when ${fld:pt} is not null then 
(case when exists(
	(select 1 from hr_staff where userlogin = '${def:user}'  and org_id = ${def:org}
		and user_id in (select user_id from hr_staff_skill where skill_id in(
			select skill_id from hr_skill where skill_scope in ('1', '2') 
			and org_id = ${def:org} and p.ptid = user_id::varchar
		))
	)
) then 1=1 else (p.ptid = ${fld:pt} or p.ptid in (select userlogin from hr_staff where
	(
		select skill_scope from hr_skill where skill_id in (select skill_id from hr_staff_skill where hr_staff_skill.user_id = hr_staff.user_id)
		 and org_id = ${def:org}
	) = '1' and org_id = ${def:org} and p.ptid = user_id::varchar
	)) end) else 1=1 end)

and (p.preparedate>=${fld:startweek} and p.preparedate<=${fld:endweek}) 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else p.ptid = '${def:user}' end)
ORDER BY p.preparedate
