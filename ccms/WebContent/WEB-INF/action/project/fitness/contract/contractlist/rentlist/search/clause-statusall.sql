and
		(case 
		--租柜合同不需要审批 zzn 2019-03-28
		--when ${fld:statusall}='1' then c.isaudit=1 --未审批
		--when ${fld:statusall}='2' then c.isaudit=3 --审批拒绝
		when ${fld:statusall}='3' then c.status=1 --未付款 1未审批 2已审批通过 3审批拒绝';
		--and (isaudit!=1 or isaudit!=3) 
		when ${fld:statusall}='4' then c.status=2 --已付款
		when ${fld:statusall}='5' then c.contracttype!=3 and  COALESCE(c.normalmoney, 0) != COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
		when ${fld:statusall}='6' then c.contracttype!=3 and COALESCE(c.normalmoney, 0) = 
 COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
			
		when ${fld:statusall}='7' then  --6未付款
			c.contracttype=3 and COALESCE(c.normalmoney, 0) != COALESCE(c.factmoney, 0)
		when ${fld:statusall}='8' then  --6已付清
			c.contracttype=3 and COALESCE(c.normalmoney, 0) = COALESCE(c.factmoney, 0)
	end)	