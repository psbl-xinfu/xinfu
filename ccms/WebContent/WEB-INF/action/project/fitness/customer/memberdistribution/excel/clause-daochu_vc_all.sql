AND 
 (
 	r.name LIKE concat('%', ${fld:daochu_vc_all}, '%') 
 	or 
 	r.mobile LIKE concat('%', ${fld:daochu_vc_all}, '%') 
 	or 
 	r.code LIKE concat('%', ${fld:daochu_vc_all}, '%') 
 	or exists(
	 	select 1 from cc_card cd where cd.customercode = r.code and cd.org_id = r.org_id
	 	and cd.isgoon = 0 and cd.status!=0 and (cd.code = ${fld:daochu_vc_all} 
	 	or cd.code in (select cardcode from cc_cardcode where incode = ${fld:daochu_vc_all} and org_id = ${def:org}))
	)
 )
 
 
  
