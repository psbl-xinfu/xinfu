and
	(case when ${fld:recharge_type}='1' then c.factmoney>=0 else c.factmoney<0 end)
