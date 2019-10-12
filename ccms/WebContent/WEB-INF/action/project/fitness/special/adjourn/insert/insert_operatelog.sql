insert into cc_operatelog
(
	code,
	opertype,
	relatedetail,
	createdate,
	createtime,
	status,
	createdby,
	remark,
	org_id,
	customercode
)
values 
(
	${seq:nextval@seq_cc_operatelog},
	'05',
	--卡号，延期前截止日期，延期天数，会员卡当时状态，
	concat(${fld:cardcode}, ';', ${fld:cardenddate}, ';', ${fld:adjourndays}
	, ';', ${fld:cardstatus}, ';', (${fld:cardenddate}::date+${fld:adjourndays})),
	'${def:date}',
	'${def:time}',
	1,
	'${def:user}',
    ${fld:remark},
    ${def:org},
    ${fld:customercode}
)



