update cc_classprepare
set
	classlistcode = ${fld:classlistcode},
	cardcode = (case when ${fld:issank}='0' then null else ${fld:cardcode} end),
	issank = ${fld:issank},
	customercode = (case when ${fld:issank}='0' then null else ${fld:customercode} end),
	custname = ${fld:cust},
	phone = ${fld:mobile}
where code = ${fld:vc_code} and org_id = ${def:org}

