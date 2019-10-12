 and
	exists(
		select 1 from dual where 
		(select created from cc_mcchange m where m.guestcode = g.code
		and m.org_id = g.org_id 
		order by created desc limit 1)<=${fld:daochu_f_entryenddate}
	)
and not exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org})