update cc_customer
set	moneycash = (moneycash::float-${fld:f_normalmoney}::float)
where code = ${fld:customer_code} and org_id = ${def:org}
and ${fld:i_paytype}='2' and ${fld:f_paycardmoneyleft}='1'