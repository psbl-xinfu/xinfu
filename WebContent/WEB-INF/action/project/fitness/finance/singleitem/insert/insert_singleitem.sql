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
	org_id
)
values 
(
	${seq:nextval@seq_cc_singleitem},
	${fld:customer_code},
    ${fld:item_insert},
    ${fld:fastcode},
    ${fld:name},
    ${fld:price},
    ${fld:unit},
    ${fld:f_amount},
    ${fld:f_money},
    ${fld:customername},
    ${fld:remark},
    (case when ${fld:i_paytype}='2' then 2 else 1 end),
    (case when ${fld:i_paytype}='2' then ${fld:f_normalmoney} else null end),
    (case when ${fld:i_paytype}='3' then 1 else 2  end),
    (case when ${fld:i_paytype}='1' then ${fld:f_normalmoney} else null end),
    ${fld:f_normalmoney},
    (case when ${fld:i_paytype}='3' then 1 else 0  end),
    ${fld:salename_insert},
    '${def:user}',
    {ts'${def:timestamp}'},
    (case when ${fld:i_paytype}='3' then null else '${def:user}'  end),
    (case when ${fld:i_paytype}='3' then null else {ts'${def:timestamp}'}  end),
    ${fld:pay_detail},
    ${def:org}
)
