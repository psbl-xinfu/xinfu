 select
  	concat('
	  <input type="checkbox"  data-am-ucheck name="datalist" isaudit="', c.isaudit,'"
	   value="',c.code,'','" code="', m.code,'" code-cttype="',c.contracttype,'" code-type="',c.type,'" code-status="',c.status,'" />
') as application_id,
 	c.code, --合同编号
 	(case c.status when 1 then '未付款' when 2 then '已付款'  else '无效' end)::varchar as i_status, --状态
 	(case c.isaudit when 1 then '未审批' when 2 then '已审批通过'  else '审批拒绝' end)::varchar as isaudit, --审批状态
 	m.name,
 	m.mobile,
 	c.contracttype,
 	c.type,
 	inimoney,
 	normalmoney,
 	factmoney,
 	(select name from hr_staff where userlogin=c.auditby) as auditby,--审批人
 	audittime,--审批时间
 	(select name from hr_staff where userlogin=c.salemember) as salemember--销售员
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where /** 普通会籍只能查看自己的会员合同 */

 1=1 and (case when EXISTS(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 ELSE c.salemember = '${def:user}' or c.salemember1 = '${def:user}' END)
and c.org_id=${def:org}
and c.isaudit!=0
${filter}
${orderby}
