select
    s.name,
    s.normalmoney,
    (case when s.isguazhang=1 then '挂账' else (
    	case when s.paytype=1 then '现金/银行卡支付' else '储蓄卡支付' end
    ) end) as payment,
    cust.code,
    cust.name as cust_name,
    (case when s.status=1 then '未付款' else '已付款' end) as status,
    (select name from hr_staff where userlogin = s.createdby) as createdby,
    s.created
from cc_singleitem s
left join cc_customer cust on cust.code=s.customercode and s.org_id=cust.org_id
where
  1=1 
  and s.org_id = ${def:org}
${filter} 
order by s.created desc

