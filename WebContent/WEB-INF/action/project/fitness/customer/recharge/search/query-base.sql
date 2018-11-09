select 
	concat('<input type="radio" name="recharge" value="', c.code, '" code="', (case when c.factmoney<0 then 0 else 1 end), '" />') AS checklink,
	c.code,
	(case when c.factmoney<0 then '退费' else '充值' end) as recharge_type,
	c.customercode,
	(select sum(factmoney) from cc_chargecard where parentcode = c.code and org_id = ${def:org}) as refund,
	cust.name,
	c.factmoney,
	c.givemoney,
	cust.moneycash,
	c.remark,
	c.createdby,
	c.created
from cc_chargecard c
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where  1=1
and c.org_id = ${def:org}
${filter} 
${orderby}
	