 and
 	(case when ${fld:f_genjintype} = '0' then 
 		not exists(
 		select 1 from cc_comm comm where comm.pk_value = 
	(select code from cc_mcchange pc where pc.customercode = r.code and pc.org_id = r.org_id order by pc.created desc limit 1)
	and comm.org_id = ${def:org} and cust_type='1'
 		)
	 else
	 exists(
 		select 1 from cc_comm comm where comm.pk_value = 
	(select code from cc_mcchange pc where pc.customercode = r.code and pc.org_id = r.org_id order by pc.created desc limit 1)
	and comm.org_id = ${def:org} and cust_type='1'
 		)
	 end)
