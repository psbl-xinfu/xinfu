select 1 from dual
where (select count(1) from cc_contract 
	where status!=0 and customercode =(select code from cc_customer
			where code=${fld:customercode} and status=0 and org_id = ${def:org}
			)  and org_id = ${def:org})>0
