 and
	exists(
		select 1 from dual where 
		(select created from cc_ptchange pc where pc.customercode = c.code
		and pc.org_id = c.org_id 
		order by pc.created desc limit 1)>=${fld:daochu_f_entryenddate}
	)
and not exists(
 		select 1 from cc_comm comm where comm.pk_value = 
	(select code from cc_ptchange pc where pc.customercode = c.code and pc.org_id = c.org_id order by pc.created desc limit 1)
	and comm.org_id = ${def:org}
 		)