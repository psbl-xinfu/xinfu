SELECT
	p.code as vc_code 
	,concat(to_char(p.preparedate,'yyyy-MM-dd') , ' ' , to_char(p.preparetime, 'HH24:mi'), '~'
		, to_char((p.preparetime::time+ (d.times||' minutes')::interval), 'HH24:mi')) AS prepare_time
	,p.cardcode as vc_cardcode
	,p.customercode as vc_customercode
	,c.name as vc_name
	,c.mobile as vc_mobile
	,(CASE WHEN p.status=0 THEN '已取消' 
		WHEN p.status=1 THEN '预约中' 
		WHEN p.status=2 THEN '已上课' 
		when p.status=3 then '爽约' ELSE '' END) AS i_statusname
	,p.starttime::time as c_starttime
	,g.created as c_itime
	,d.ptlevelname as vc_ptlevelname
	,d.ptfee as f_ptfee
	,d.scale as f_scale
	,g.leftcount::integer as f_leftcount
	,(select name from hr_staff where hr_staff.userlogin = p.createdby) as vc_iuser 
	,(case when g.ptid is not  null or g.ptid!=''
	then (select name from hr_staff where hr_staff.userlogin = g.ptid)
	else (select name from hr_staff where hr_staff.userlogin = 
		(select ptid from cc_ptrest t where t.code=p.ptrestcode and t.org_id = ${def:org} limit 1)) 
	end
	) AS pt_name
	,p.ptrestcode as ptrestid,
	d.ptlevelname
FROM cc_ptprepare p 
LEFT JOIN cc_ptlog g ON p.code = g.preparecode and p.org_id = g.org_id
left join cc_ptrest pr on p.ptrestcode = pr.code and p.org_id = pr.org_id
LEFT JOIN cc_ptdef d ON pr.ptlevelcode = d.code and d.org_id = pr.org_id
LEFT JOIN hr_staff f ON p.ptid = f.userlogin
LEFT JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id
WHERE /** 私人教练只能查看自己的会员 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else p.ptid = '${def:user}' end)
AND p.status in (2,3) and p.org_id = ${def:org} and c.code = ${fld:cust_code}
and p.preparedate>=${fld:startdate} and p.preparedate<=${fld:enddate}
and (case when ${fld:ptid} is null then 1=1 else p.ptid = ${fld:ptid} end)
and (case when ${fld:ptdefcode} is null then 1=1 else d.code = ${fld:ptdefcode} end)
order by p.preparedate desc,p.preparetime desc
