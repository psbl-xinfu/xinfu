insert into cc_finance(
      code,
      customercode,
      operatelogcode,
      salesman,
      type,
      createdby,
      created,
      pay_detail,
      premoney,--预付款
      money,--收入
      moneyleft,--欠款
      org_id,
      item
)
values 
(
	${seq:nextval@seq_cc_finance},
    ${fld:customer_code},
    ${seq:currval@seq_cc_operatelog},
    ${fld:salename_insert},
    '3',
    '${def:user}',    
    {ts'${def:timestamp}'},
    ${fld:pay_detail},
    (case when ${fld:i_paytype}='2' then ${fld:f_normalmoney} else null end),
    (case when ${fld:i_paytype}='1' then ${fld:f_normalmoney} else null end),
	-(case when ${fld:i_paytype}='1' then ${fld:f_normalmoney} else null end),
    ${def:org},
    33
)
