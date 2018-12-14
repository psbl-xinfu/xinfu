select
    concat('<input type="radio" name="singleitemlist" value="', s.code, '" code="', s.status, '" />') AS radiolink,
    s.name,
    s.normalmoney,
    (case when s.isguazhang=1 then '挂账' else (
    	case when s.paytype=1 then '现金/银行卡支付' else '储蓄卡支付' end
    ) end) as payment,
    (case when (select c.mobile from cc_customer c where c.mobile =
  ${fld:mobile}) is null then g.code 
  else cust.code  end ) as code,
   (case when (select c.mobile from cc_customer c where c.mobile =
  ${fld:mobile}) is null then g.mobile 
  else cust.mobile  end ) as mobile,
  (case when (select c.mobile from cc_customer c where c.mobile =
  ${fld:mobile}) is null then g.name 
  else cust.name  end ) as cust_name,
    (case when s.status=1 then '未付款' else '已付款' end) as status,
    (select name from hr_staff where userlogin = s.createdby) as createdby,
    s.created
from cc_singleitem s
left join cc_customer cust on cust.code=s.customercode and s.org_id=cust.org_id
left join cc_guest g on g.code=s.customercode and s.org_id=g.org_id

where
  1=1 
  and 
  (case when (select c.mobile from cc_customer c where c.mobile =
  ${fld:mobile}) is null then g.mobile = ${fld:mobile} 
  else cust.mobile = ${fld:mobile}  end )
  and s.org_id = ${def:org}
${filter} 
${orderby}

