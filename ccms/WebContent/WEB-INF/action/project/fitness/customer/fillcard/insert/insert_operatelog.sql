insert into cc_operatelog
(
	code,
	opertype,
	org_id,
	relatedetail,
   	createdate,
   	createtime,
   	createdby,
	remark,
	inimoney,
	normalmoney,
	factmoney,
	status,
	pay_detail
)
values 
(
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')||${seq:nextval@seq_cc_operatelog},
	'08',
	${def:org},
	${fld:customercode}||';'||${fld:cardcode}||';'||${fld:new_vc_code},
    '${def:date}',
    '${def:time}',
    '${def:user}',
    ${fld:remark},
    ${fld:fillcardmoney},
    ${fld:fillcardmoney},
    ${fld:fillcardmoney},
    1,
    ${fld:pay_detail}
)


