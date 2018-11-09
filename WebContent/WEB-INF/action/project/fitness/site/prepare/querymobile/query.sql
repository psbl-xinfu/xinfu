select 
	(select count(1) from cc_guest where mobile = ${fld:mobile} and org_id = ${def:org})
	+
	(select count(1) from cc_customer where mobile = ${fld:mobile} and org_id = ${def:org}) as num from dual
