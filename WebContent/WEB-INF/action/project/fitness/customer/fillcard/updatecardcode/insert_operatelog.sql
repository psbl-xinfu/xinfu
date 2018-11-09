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
	${fld:in_bianhao}||';'||${fld:vc_code}||';'||${fld:new_vc_code},
    '${def:date}',
    '${def:time}',
    '${def:user}',
    ${fld:vc_remark},
    ${fld:bukafei},
    ${fld:bukafei},
    ${fld:bukafei},
    1,
    ${fld:pay_detail}
)


