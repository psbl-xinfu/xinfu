 and
 	(case when ${fld:f_genjintype} = '0' then 
 		not exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	 else
	 exists(
 		select 1 from cc_comm comm where comm.preparecode = 
	(select code from cc_guest_prepare mh where mh.guestcode = g.code and mh.org_id = g.org_id order by mh.created desc limit 1)
	and comm.org_id = ${def:org}
 		)
	 end)
