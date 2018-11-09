update cc_customer
set moneycash = (case when ${fld:othermoney}='1' then moneycash - ${fld:total} else moneycash end),
	moneygift = (case when ${fld:othermoney}='2' then moneygift - ${fld:total} else moneygift end)
where code = ${fld:custcode}
and org_id = ${def:org} and ${fld:othertype}='2'
