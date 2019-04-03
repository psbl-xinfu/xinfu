and
	(case when ${fld:opencardway}='1' then (st.updatedby is null or st.updatedby ='')
	else st.updatedby is not null end)
	and st.status = 2
