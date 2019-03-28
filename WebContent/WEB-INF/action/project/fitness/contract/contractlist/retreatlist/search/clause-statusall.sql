and
	(case 
	  --退卡合同不需要审批 zzn 2019-03-28
	  --when ${fld:statusall}='1' then c.isaudit=1
	  --when ${fld:statusall}='2' then c.isaudit=3
		when ${fld:statusall}='3' then c.status=1
		when ${fld:statusall}='4' then c.status=2
		when ${fld:statusall}='5' then c.contracttype!=3 
			and COALESCE(c.normalmoney, 0)=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id), 0))
		when ${fld:statusall}='6' then c.contracttype!=3 
			and COALESCE(c.normalmoney, 0)!=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id), 0))
	end)	
