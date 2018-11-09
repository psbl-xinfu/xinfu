and
	(case when ${fld:daochu_cust} is null 
		then st.created::date between ${fld:daochu_c_startdate} 
			and ${fld:daochu_c_startdatee} else 1=1 end)
