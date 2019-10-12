and
	(cust.code like concat('%', ${fld:daochu_custall}, '%')
		or cust.name like concat('%', ${fld:daochu_custall}, '%')
		or cust.mobile like concat('%', ${fld:daochu_custall}, '%')
		or exists(
			select 1 from cc_card where isgoon = 0 and status!=0 and org_id = ${def:org}
			and customercode = cust.code 
			and (code like concat('%', ${fld:daochu_custall}, '%')
			or 
			code in (select cardcode from cc_cardcode where incode = ${fld:daochu_custall} and org_id = ${def:org})
			)
		)
	)
