update cc_customer set 
	org_id = ${fld:orgcode}
where code=${fld:customercode} and org_id = ${def:org}