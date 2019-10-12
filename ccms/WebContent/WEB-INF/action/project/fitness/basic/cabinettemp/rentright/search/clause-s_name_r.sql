and
(
	exists (
		select 1 from cc_customer c where  b.customercode=c.code
		and c.org_id=${def:org}
		and (
			c.name like concat('%', ${fld:s_name_r}, '%')   
			or
			c.mobile like concat('%', ${fld:s_name_r}, '%') 
			or
			exists(
				select 1 from cc_card card
				where card.isgoon = 0 and card.status!=0
				and card.customercode = c.code 
				and card.code in (select cardcode from cc_cardcode where incode = ${fld:s_name_r} and org_id = ${def:org})
			)
			)
	)
	or
	
	b.cabinettempcode like '%'||${fld:s_name_r}||'%' )