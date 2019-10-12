select 1 from cc_customer
where code = ${fld:customer_code} and org_id = ${def:org}
and ${fld:i_paytype}='2' and ${fld:f_paycardmoneyleft}='1'
and moneycash<${fld:f_normalmoney}