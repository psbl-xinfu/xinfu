update cc_customer set 
	org_id = ${fld:orgcode},
	mc=${fld:mcid}
where code=${fld:customercode} and org_id = ${def:org}