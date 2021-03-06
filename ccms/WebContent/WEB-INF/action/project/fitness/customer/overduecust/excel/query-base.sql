select
	cust.name,
	(case cust.sex when '0' then '女' when '1' then '男' else '未知' end) as sex,
	cust.mobile,
	(select name from hr_staff where userlogin=cust.mc and org_id = cust.org_id) as mc,
 	(select enddate from cc_card where customercode = cust.code and org_id = cust.org_id 
 		and cc_card.isgoon = 0 order by enddate desc limit 1) as enddate
from cc_customer cust
where cust.org_id = ${def:org}
and not EXISTS(
	select 1 from cc_card 
	where isgoon=0 and status!=0 and status!=6
	and cust.code = customercode 
	and org_id = cust.org_id
)
and 
/* 判断当前登录人是否是私教，私教查询全部会员*/
(case when (select skill_scope from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}')::integer = 1 then 1=1 else 
/** 会籍顾问只能查看自己的数据 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else cust.mc = '${def:user}' end) end)
${filter}
order by cust.created desc
