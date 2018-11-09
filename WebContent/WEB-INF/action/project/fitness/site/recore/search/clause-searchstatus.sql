and
	(case
		when ${fld:searchstatus}=5 then sd.paystatus = 1
		when ${fld:searchstatus}=6 then sd.paystatus = 0
		else sd.status = ${fld:searchstatus}
	end)