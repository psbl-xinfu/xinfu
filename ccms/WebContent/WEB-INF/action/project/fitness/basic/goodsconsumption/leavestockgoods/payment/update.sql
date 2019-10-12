update cc_leave_stock set 
	getmoney=factmoney,
	paystatus=2,
	paytype=${fld:othertype},
	paycardmoneyleft=(case when ${fld:othertype}='2' and ${fld:othermoney}='1' then (select moneycash from cc_customer where code = ${fld:custcode} and org_id = ${def:org})
	 when ${fld:othertype}='2' and ${fld:othermoney}='2' then (select moneygift from cc_customer where code = ${fld:custcode} and org_id = ${def:org})
	end),
	isguazhang=0,
	pay_detail = ${fld:pay_detail},
	updatedby='${def:user}',
	updated={ts'${def:timestamp}'}
where
	tuid = ${fld:tuid} and org_id = ${def:org}
