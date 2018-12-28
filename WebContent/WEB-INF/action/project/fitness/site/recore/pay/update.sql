update cc_siteusedetail set 
	paystatus=1,
	premoney=${fld:normalmoney},
	normalmoney=${fld:normalmoney},
	factmoney=${fld:factmoney},
	remark=${fld:remark},
	billcode=${seq:currval@seq_cc_finance}
where code=${fld:code}
and org_id = ${def:org}

	
