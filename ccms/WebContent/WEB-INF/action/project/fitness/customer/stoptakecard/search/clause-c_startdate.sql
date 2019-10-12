and
	(case when ${fld:cust} is null then st.created::date between ${fld:c_startdate} and ${fld:c_startdatee} else 1=1 end)
