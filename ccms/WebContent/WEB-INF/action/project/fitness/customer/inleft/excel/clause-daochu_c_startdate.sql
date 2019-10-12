and
	(case when ${fld:daochu_vc_cardcode} is null 
		then inleft.intime::date>= ${fld:daochu_c_startdate} and inleft.intime::date <= ${fld:daochu_c_enddate} 
		else 1=1 end)