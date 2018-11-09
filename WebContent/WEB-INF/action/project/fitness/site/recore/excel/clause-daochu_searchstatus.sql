and
	(case
		when ${fld:daochu_searchstatus}=5 then sd.paystatus = 1
		when ${fld:daochu_searchstatus}=6 then sd.paystatus = 0
		else sd.status = ${fld:daochu_searchstatus}
	end)
