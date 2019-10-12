and
	(case
		when ${fld:contracttype}='1' then not (c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney) and not (c.contracttype=3 and c.relatecode is not null and c.relatecode!='')
		when ${fld:contracttype}='2' then c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney
		when ${fld:contracttype}='3' then c.contracttype=3 and c.relatecode is not null and c.relatecode!=''
	end)
 
