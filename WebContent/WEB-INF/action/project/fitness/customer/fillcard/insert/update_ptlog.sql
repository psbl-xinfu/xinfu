update cc_ptlog set 
	cardcode=${fld:new_vc_code}
where customercode=${fld:customercode} and org_id = ${def:org}
