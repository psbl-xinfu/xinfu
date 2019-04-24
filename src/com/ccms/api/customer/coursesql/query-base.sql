--zyb 20190422 查询该教练的所有预约课程
SELECT
	p.code as ReservationID
	,(p.preparedate+p.preparetime) as ReservationTime
	,p.status as ReservationStatus
	,(select name from hr_staff where userlogin = p.ptid) as EmployeeName
	,p.customercode as MemberID
	,c.name as MemberName
	,c.mobile as MemberMobile
	,d.ptlevelname as LessonName
	,(case when p.status=2 then  g.leftcount::integer else pr.ptleftcount::integer end) as StillNumber
	,d.times as ReservationNumber
	,g.created as LessonStartTime
	,g.quittingtime as LessonEndTime
FROM cc_ptprepare p 
LEFT JOIN cc_ptlog g ON p.code = g.preparecode and p.org_id = g.org_id
left join cc_ptrest pr on p.ptrestcode = pr.code and p.org_id = pr.org_id
LEFT JOIN cc_ptdef d ON pr.ptlevelcode = d.code and d.org_id = pr.org_id
LEFT JOIN hr_staff f ON p.ptid = f.userlogin
LEFT JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id
WHERE p.org_id = ${fld:org} and p.status=${fld:status}
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${fld:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = ${fld:employeeId}))
			and hss.userlogin = ${fld:employeeId} and hs.data_limit = 1)
			then 1=1 else p.ptid = ${fld:employeeId} end)