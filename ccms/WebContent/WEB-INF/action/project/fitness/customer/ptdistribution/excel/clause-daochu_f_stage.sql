 and
 	exists(
 		select 1 from cc_comm comm where comm.stage = ${fld:daochu_f_stage}
 		and comm.customercode = c.code and comm.org_id = c.org_id
 		order by comm.created desc limit 1
 	)
and exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_prepare mh where mh.customercode = c.code and mh.org_id = c.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
