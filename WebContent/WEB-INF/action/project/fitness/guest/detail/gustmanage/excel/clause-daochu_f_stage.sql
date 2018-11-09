 and
 	exists(
 		select 1 from cc_comm comm where comm.stage = ${fld:daochu_f_stage}
 		and comm.guestcode = g.code and comm.org_id = g.org_id
 		order by comm.created desc limit 1
 	)
and exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
