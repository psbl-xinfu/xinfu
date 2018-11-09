select 
	(select count(1) from cc_guest where mobile = ${fld:mobile} and org_id = ${fld:org_id})
	+
	(select count(1) from cc_customer where mobile = ${fld:mobile} and org_id = ${fld:org_id}) as num from dual
