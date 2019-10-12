and
	(case 
		when ${fld:daochu_statusall}='1' then c.isaudit=1
		when ${fld:daochu_statusall}='2' then c.isaudit=3
		when ${fld:daochu_statusall}='3' then c.status=1
		when ${fld:daochu_statusall}='4' then c.status=2
		when ${fld:daochu_statusall}='5' then c.contracttype!=3 
			and COALESCE(c.normalmoney, 0)=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id), 0))
		when ${fld:daochu_statusall}='6' then c.contracttype!=3 
			and COALESCE(c.normalmoney, 0)!=(COALESCE(c.factmoney, 0)+COALESCE((select ct.factmoney from cc_contract ct 
			where ct.code = c.relatecode and ct.org_id = c.org_id), 0))
	end)	
