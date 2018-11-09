AND 
	(case when ${fld:daochu_name} is null then createdate <= ${fld:daochu_end_date} else 1=1 end)

