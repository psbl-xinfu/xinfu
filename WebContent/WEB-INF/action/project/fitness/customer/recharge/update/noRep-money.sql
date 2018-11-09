select 1 from dual
where (select moneycash from cc_customer 
	where code = ${fld:cust_code} and org_id = ${def:org})<${fld:moneycash}
