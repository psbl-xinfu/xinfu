update cc_siteusedetail set 
	paystatus=0,
	premoney=${fld:normalmoney},
	factmoney=${fld:normalmoney},
	remark=${fld:remark},
	billcode=${seq:currval@seq_cc_finance}
where code=${fld:code}
and org_id = ${def:org}

	
