and (
	   c.code like concat('%', ${fld:pickcustname}, '%') 
	or cust.mobile like concat('%', ${fld:pickcustname}, '%') 
	or cust.name like concat('%', ${fld:pickcustname}, '%')
	or cust.code like concat('%', ${fld:pickcustname}, '%')
	or c.code in (select cardcode from cc_cardcode where incode = ${fld:pickcustname} and org_id = ${def:org})
)