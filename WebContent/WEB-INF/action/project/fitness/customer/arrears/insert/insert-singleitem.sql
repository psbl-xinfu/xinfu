insert into cc_singleitem(
	code,
	customercode,
	itemcode,
	fastcode,
	name,
	price,
	unit,
	amount,
	money,
	customername,
	remark,
	paytype,
	paycardmoneyleft,
	status,
	getmoney,
	normalmoney,
	isguazhang,
	seller,
	createdby,
	created,
	collectby,
	collectdate,
	pay_detail,
	org_id,
	discount
)
values 
(
	${seq:nextval@seq_cc_singleitem},
	${fld:customercode},
    ${fld:item_insert},
    ${fld:fastcode},
    ${fld:name},
    ${fld:price},
    (case when ${fld:unit}='次' then '0'::int 
    when ${fld:unit}='张' then '1'::int
    else null
    end),
    ${fld:f_amount},
    ${fld:f_money},
    ${fld:cust_name},
    ${fld:remark},
    (case when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float=${fld:f_normalmoney}::float  then '2'::integer 
	when ${fld:paydivgoodsinp}='f_chuzhika' and ${fld:paytheprice}::float!=${fld:f_normalmoney}::float then '3'::integer
	when  ${fld:getmoney}::float=${fld:f_normalmoney}::float  then '1'::integer
	else null end),
    (case when ${fld:paydivgoodsinp}='f_chuzhika' then (select moneycash from cc_customer where code = ${fld:customercode} and org_id = ${def:org})
	 else null
	end),
    2,
   ${fld:getmoney} ,
    ${fld:f_normalmoney},
     0,
    ${fld:salename_insert},
    '${def:user}',
    {ts'${def:timestamp}'},
   '${def:user}',
   {ts'${def:timestamp}'},
    ${fld:pay_detail},
    ${def:org},
    ${fld:vc_rebate}
)
