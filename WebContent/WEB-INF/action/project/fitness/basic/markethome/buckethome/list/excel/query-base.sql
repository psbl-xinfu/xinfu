 select
 	'<input type="checkbox" class="duoxuan" name="datalist"  value="'||COALESCE(c.code,'')||'" >' as application_id,
 	c.code, --合同编号
 	(case c.status when 1 then '未付款' when 2 then '已付款'  else '无效' end)::varchar as i_status, --状态
 	(case c.isaudit when 1 then '未审批' when 2 then '已审批通过'  else '审批拒绝' end)::varchar as isaudit, --审批状态
 	m.name,
 	m.mobile,
 	normalmoney,
 	factmoney,
 	(select name from hr_staff where userlogin=c.auditby and org_id = ${def:org}) as auditby,--审批人
 	audittime,--审批时间
 	(select name from hr_staff where userlogin=c.salemember and org_id = ${def:org}) as salemember--销售员
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where /** 普通会籍只能查看自己的会员合同 */
 (
	CASE WHEN (SELECT hs.data_limit FROM hr_staff hs WHERE hs.userlogin = '${def:user}'   and org_id = ${def:org} LIMIT 1) = 1 
	THEN true ELSE c.salemember = '${def:user}' END
) 
and c.org_id=${def:org}
and c.isaudit!=0
${filter}
order by c.createdate desc