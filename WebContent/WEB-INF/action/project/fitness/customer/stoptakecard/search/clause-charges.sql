and
	(case when ${fld:charges}='1' then st.status!=10 else st.status=10 end)
