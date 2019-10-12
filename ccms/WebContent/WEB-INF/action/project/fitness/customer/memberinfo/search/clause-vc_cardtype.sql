 and
	exists(
		select 1 from cc_card where cardtype = ${fld:vc_cardtype} 
		and customercode = r.code
	)
