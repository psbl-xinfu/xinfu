and
	(case
		when ${fld:daochu_contracttype}='1' then not (c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney) and not (c.contracttype=3 and c.relatecode is not null and c.relatecode!='')
		when ${fld:daochu_contracttype}='2' then c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney
		when ${fld:daochu_contracttype}='3' then c.contracttype=3 and c.relatecode is not null and c.relatecode!=''
	end)
 
