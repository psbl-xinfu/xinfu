and
	(case when ${fld:classtype}='0' then
		ptfee=0
	else 
		ptfee>0
	end)
