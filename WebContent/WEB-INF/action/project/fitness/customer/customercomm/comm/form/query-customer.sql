select code,name,mobile from cc_customer where code = ${fld:customercode} 
and org_id = ${def:org}

union

select code,name,mobile from cc_guest where code = ${fld:guestcode} 
and org_id = ${def:org}
	