INSERT INTO cc_operatelog (
	code,
	opertype,
	relatedetail,
	createdate,
	createtime,
	createdby,
	status,
	remark,
	org_id,
	customercode
) VALUES(
	${seq:nextval@seq_cc_operatelog},
	'67',
	concat(
		${fld:moneycash}, ';', ${fld:givemoneycash}, ';', ${fld:moneygift}, ';', ${fld:givemoneygift}
	),
	'${def:date}',
	'${def:time}',
	'${def:user}',
	1,
	${fld:remark},
	${def:org},
	${fld:customercode}
)