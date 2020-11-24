select 
	concat('<input type="radio" name="ptrestradio" value="', pr.code,'" code="', pr.ptenddate,'" reatetype="', p.reatetype,'" ptid="', (case when p.reatetype=1 then cust.pt else pr.ptid end),'" ') as ptrestradio,
	cust.name,
	cust.mobile,
	p.ptlevelname,
	(case
		when pr.pttype=1 then '新买课'
		when pr.pttype=2 then '场地开发'
		when pr.pttype=3 then '续课'
		when pr.pttype=4 then '转课'
		when pr.pttype=5 then '赠课'
		when pr.pttype=6 then '更换'
	end) as pttype,--来源：1新买课、2场地开发、3续课、4转课、5赠课
	pr.pttotalcount::integer,--购买节数
	pr.ptleftcount::integer,--剩余节数
	(select name from hr_staff where userlogin = (case when p.reatetype=1 then cust.pt else pr.ptid end)) as ptid,-- 私教
	pr.created,-- 购买时间
	pr.ptenddate,--结束日期
	('${def:date}'::date - pr.created::date) AS buyday,	-- 已购课天数
	(select sum(delayday) from cc_ptrest_delay where ptrestcode=pr.code and org_id = pr.org_id) as delayday --已延期次数
	
from cc_ptrest pr
left join cc_customer cust on pr.customercode = cust.code and pr.org_id = cust.org_id
left join cc_ptdef p on p.code = pr.ptlevelcode and p.org_id = pr.org_id
where (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}')) and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else pr.createdby = '${def:user}' end)
and pr.org_id = ${def:org} and pr.ptleftcount > 0
${filter} 
${orderby}


