and
	(case when ${fld:daochu_charges}='1' then st.status!=10 else st.status=10 end)
