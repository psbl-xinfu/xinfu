select ct.name as thename,
ct.mobile,
(case when type = 2  then get_arr_value(log.contents,0)
else (select officename from cc_guest where  code= log.yguestcode)
end) as yofficename,(select officename from cc_guest where  code= log.xguestcode) as xofficename,(case when type=1 then '转移' else '合并' end) as logtype,
(select name from hr_staff where userlogin=log.ymc) as ymcname,
(select name from hr_staff where userlogin=log.xmc) as xmcname,
(select name from hr_staff where userlogin=log.createdby) as createdby,
log.created
from cc_merger_transfer_log  log
left join cc_thecontact ct on ct.code=log.thecode
where (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else log.createdby = '${def:user}' end)
${filter} 
order by log.created desc