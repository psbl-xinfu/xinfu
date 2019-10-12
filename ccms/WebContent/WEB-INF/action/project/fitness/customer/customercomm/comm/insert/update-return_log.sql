update cc_return_log
set commcode=${seq:currval@seq_cc_comm}
where (case 
 	when ${fld:cust_type}='0' then pk_value=${fld:guestcode}
	when ${fld:cust_type}='1' then pk_value=${fld:customercode} end)
and org_id = ${def:org}