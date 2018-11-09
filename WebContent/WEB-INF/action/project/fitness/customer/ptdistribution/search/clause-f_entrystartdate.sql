 and
	exists(
		select 1 from dual where 
		(select created from cc_ptchange pc where pc.customercode = c.code
		and pc.org_id = c.org_id 
		order by pc.created desc limit 1)>=${fld:f_entrystartdate}
	)
and not exists(
 		select 1 from cc_comm comm where comm.pk_value = 
	(select code from cc_ptchange pc where pc.customercode = c.code and pc.org_id = c.org_id order by pc.created desc limit 1)
	and comm.org_id = ${def:org} and cust_type='2'
 		)