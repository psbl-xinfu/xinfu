and
	((select (st.startdate::date + concat(st.prestopdays ,' d')::interval))::date-'${def:date}'::date)<=${fld:days}
	and st.stoptype=2 and st.status=1
