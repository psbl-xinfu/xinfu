and
	(case when ${fld:vc_cardcode} is null 
		then inleft.intime::date>= ${fld:c_startdate} and inleft.intime::date <= ${fld:c_enddate} 
		else 1=1 end)
