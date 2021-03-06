and
		(case 
		when ${fld:statusall}='1' then c.isaudit=1 --未审批
		when ${fld:statusall}='2' then c.isaudit=3 --审批拒绝
		when ${fld:statusall}='3' then c.status=1 and (isaudit!=1 or isaudit!=3) --未付款 1未审批 2已审批通过 3审批拒绝';
		when ${fld:statusall}='4' then c.status=2 --已付款
		when ${fld:statusall}='5' then c.contracttype!=3 --5未还款
		and COALESCE(c.normalmoney, 0)!=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id and ct.status =2 and ct.type!=2 ), 0))  and c.status=2 and c.normalmoney != (case when 
(select ct.factmoney from cc_contract ct 
			where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 and ct.type!=2 ) is null then '0' else (select (ct.factmoney+c.factmoney) as bin from cc_contract ct 
			where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 and ct.type!=2 )
end)
		when ${fld:statusall}='6' then c.contracttype!=3 --6已还款
			and COALESCE(c.normalmoney, 0)!=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id and ct.status =2 and ct.type!=2 ), 0)) and c.status=2 
			and c.normalmoney = (select (ct.factmoney+c.factmoney) from cc_contract ct 
			where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 and ct.type!=2 )
			
		when ${fld:statusall}='7' then  --6未付款
			c.contracttype=3 and COALESCE(c.normalmoney, 0) != COALESCE(c.factmoney, 0)
		when ${fld:statusall}='8' then  --6已付清
			c.contracttype=3 and COALESCE(c.normalmoney, 0) = COALESCE(c.factmoney, 0)
	end)	