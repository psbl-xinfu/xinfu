select 
		count(d.code) as num
from cc_card d 
inner join cc_contract t on t.code = d.contractcode and t.org_id = d.org_id 
inner join cc_customer c on d.customercode = c.code and c.org_id = d.org_id 
left join hr_staff f on c.mc = f.userlogin 
inner join cc_cardtype e on e.code = d.cardtype and e.org_id = d.org_id 
left join cc_cardcategory y on y.code = e.cardcategory and y.org_id = e.org_id 
where d.code = ${fld:cardcode} and d.org_id = ${def:org} and d.isgoon =1  
and d.status != 0 and d.status != 6 and t.status >= 2 
and t.normalmoney = COALESCE(t.factmoney,0.00) + COALESCE((
	select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
	where t2.relatecode = t.code and t2.org_id = t.org_id and t2.status >= 2
),0.00) 
and e.maxusernum = 1
