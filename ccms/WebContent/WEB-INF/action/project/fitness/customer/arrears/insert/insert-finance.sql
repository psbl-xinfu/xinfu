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
      money, --收入
      moneyleft,--欠款
      org_id,
      item
)
values 
(
	${seq:nextval@seq_cc_finance},
    ${fld:customercode},
    ${seq:currval@seq_cc_operatelog},
    ${fld:salename_insert},
    '3',
    '${def:user}',    
    {ts'${def:timestamp}'},
    ${fld:pay_detail},
     ${fld:f_normalmoney}, --储值卡
     ${fld:getmoney}, --现金
    0, --挂账
    ${def:org},
    33
)
