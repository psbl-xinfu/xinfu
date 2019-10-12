update cc_customer
set	moneygift = (moneygift::float-${fld:f_normalmoney}::float)
where code = ${fld:customer_code} and org_id = ${def:org}
and ${fld:i_paytype}='2' and ${fld:f_paycardmoneyleft}='2'