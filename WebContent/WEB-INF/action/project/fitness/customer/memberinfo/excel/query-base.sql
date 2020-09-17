select distinct cust.name as custname,cust.mobile,
(case cust.sex when '0' then '女' when '1' then '男' else '未知'  end) as sex
,cust.remark as custremark,(case cd.status when '0' then '无效'
when '1' then '正常'
when '2' then '未启用'
when '3' then '存卡中'
when '4' then '挂失中'
when '5' then '停卡中'
when '6' then '过期'
 
end) as status,ct.name,ct.remark,cd.code,
cc.incode,con.factmoney,iit.indate,cd.startdate,
cd.enddate,cd.count,cd.nowcount,scd.prestopdays,
scd.factstopdays,scd.reason,scd.money
from cc_card cd
left join cc_contract con on con.code = cd.contractcode
left join cc_customer cust on cd.customercode=cust.code
left join cc_cardcode cc on cc.cardcode=cd.code and cc.status=1
left join cc_cardtype ct on ct.code=cd.cardtype  
LEFT JOIN cc_savestopcard scd on scd.cardcode=cd.code and scd.stoptype='1'
LEFT JOIN 
(select it.indate,it.customercode,it.cardcode,it.org_id from cc_inleft it  
RIGHT JOIN 
(select  max(c.code) code from cc_inleft c  group by customercode  ) c  on c.code=it.code) iit on iit.cardcode=cd.code and iit.org_id=cd.org_id
 
where cd.org_id=${def:org} and cd.isgoon!='-1'  and cust.status!=0
/* 判断当前登录人是否是私教，私教查询全部会员*/
and (case when (select skill_scope from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}')::integer = 1 then 1=1 else 
/** 会籍顾问只能查看自己的数据 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else cust.mc = '${def:user}' end) end)
AND cd.org_id = ${def:org} 
 ${filter}
 
order by indate desc