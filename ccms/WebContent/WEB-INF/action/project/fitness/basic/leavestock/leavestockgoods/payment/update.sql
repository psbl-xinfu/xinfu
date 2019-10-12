update cc_leave_stock set 
	getmoney=factmoney,
	paystatus=2,
	paytype=(case when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float=${fld:total}::float  then '2'::integer 
	when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float!=${fld:total}::float then '3'::integer
	when  ${fld:getmoney}::float=${fld:total}::float  then '1'::integer
	else null end),
	paycardmoneyleft=(case when ${fld:paydivgoodsinp}='f_chuzhika' then (select moneycash from cc_customer where code = ${fld:custcode} and org_id = ${def:org})
	 else null
	end),
	isguazhang=0,
	pay_detail = ${fld:pay_detail},
	updatedby='${def:user}',
	updated={ts'${def:timestamp}'}
where
	tuid = ${fld:tuid} and org_id = ${def:org}
