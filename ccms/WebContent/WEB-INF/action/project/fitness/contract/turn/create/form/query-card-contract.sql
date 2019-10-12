select 
	d.code as cardcode
	,d.contractcode 
from cc_card d 
inner join cc_contract t on t.code = d.contractcode and t.org_id = d.org_id 
inner join cc_customer c on d.customercode = c.code and c.org_id = d.org_id 
inner join cc_cardtype e on e.code = d.cardtype and e.org_id = d.org_id 
where d.customercode = (
	case when ${fld:contractcode} is not null and ${fld:contractcode} != '' then (
		select get_arr_value(t2.relatedetail, 20) from cc_contract t2 where t2.code = ${fld:contractcode} and t2.org_id = d.org_id 
	) else ${fld:customercode} end 
) and d.org_id = ${def:org} and d.isgoon = 0 
and d.status != 0 and d.status != 6 and t.status >= 2 
and t.normalmoney = COALESCE(t.factmoney,0.00) + COALESCE((
	select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
	where t2.relatecode = t.code and t2.org_id = t.org_id and t2.status >= 2
),0.00) 
and e.maxusernum = 1
and (d.relatecode is null or d.relatecode='') --排除副卡

