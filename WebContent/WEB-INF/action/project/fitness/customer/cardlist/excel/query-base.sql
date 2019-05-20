select
	card.code as cardcode,
	ct.name as cardtypename,
	cust.name,
	cust.mobile,
	card.startdate,
	card.enddate,
	(case when card.status=0 then '无效' when card.status=1 then '正常' when card.status=2 then '未启用'
		  when card.status=3 then '存卡中' when card.status=4 then '挂失中' when card.status=5 then '停卡中'
		  when card.status=6 then '过期' end) as status,
	(select name from hr_staff where userlogin = cust.mc) as mcstaff,	
		(case when ct.type=1 then concat(card.count,'次') 
  when ct.type=0 then concat(card.totalday,'天') 
	else '--' end) as count,--卡权益	
	(case when ct.type=1 then concat(card.nowcount,'次') 
  when ct.type=0 then concat(date_part('day',enddate-now()),'天') 
	else '--' end) as nowcount,
	card.remark
from cc_card card
left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
left join cc_customer cust on cust.code = card.customercode and card.org_id= cust.org_id
where  card.isgoon = 0 and card.org_id = ${def:org}
and (card.relatecode is null or card.relatecode='')
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
order by card.created desc
