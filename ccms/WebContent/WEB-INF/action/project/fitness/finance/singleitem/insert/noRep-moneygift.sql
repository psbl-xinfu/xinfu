select 1 from cc_customer
where code = ${fld:customer_code} and org_id = ${def:org}
and ${fld:i_paytype}='2' and ${fld:f_paycardmoneyleft}='2'
and moneygift<${fld:f_normalmoney}