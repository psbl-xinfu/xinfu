select 1 from dual
where (select count(1) from cc_contract 
	where status!=0 and guestcode = ${fld:guestcode} and org_id = ${def:org})>0
