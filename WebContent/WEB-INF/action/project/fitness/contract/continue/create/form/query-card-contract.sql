--zzn 取俱乐部编码
with title as 
(select hr_org.memberhead from hr_org  where hr_org.org_id= ${def:org} )
--
select
	d.code as cardcode
	--,d.contractcode 
	,(case WHEN EXISTS (  --zzn 如果已经存在未启用的续卡
			select 1 from cc_card d2 
			where d2.code = d.code and d2.org_id = d.org_id and d2.isgoon = 1 and d2.status != 0 and d2.status != 6 
			)
	 	then (select concat((select * from title), max(substring(cd.contractcode from E'([0-9]+)')::NUMERIC)::VARCHAR) from cc_card cd where cd.code= d.code)  	       
     else  (d.contractcode )   end
	) as contractcode
from cc_card d 
inner join cc_contract t on t.code = d.contractcode and t.org_id = d.org_id 
inner join cc_customer c on d.customercode = c.code and c.org_id = d.org_id 
inner join cc_cardtype e on e.code = d.cardtype and e.org_id = d.org_id 
where d.customercode = (
	case when ${fld:contractcode} is not null and ${fld:contractcode} != '' then (
		select t2.customercode from cc_contract t2 where t2.code = ${fld:contractcode} and t2.org_id = d.org_id 
	) else ${fld:customercode} end 
) and d.org_id = ${def:org} and d.isgoon = 0 
and d.status != 0 and d.status != 6 and t.status >= 2 
and t.normalmoney = COALESCE(t.factmoney,0.00) + COALESCE((
	select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
	where t2.relatecode = t.code and t2.org_id = t.org_id and t2.status >= 2
),0.00) 
--zzn 可以连续续卡
--and not exists(
--	select 1 from cc_card d2 
--	where d2.code = d.code and d2.org_id = d.org_id and d2.isgoon = 1 and d2.status != 0 and d2.status != 6 
--)
and e.maxusernum = 1
and (d.relatecode is null or d.relatecode='') --排除副卡
