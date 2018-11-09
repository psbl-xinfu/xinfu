insert into cc_enter_stock
(
	tuid,
	storageid,
	remark,
	status,
	created,
	createdby,
	org_id
)
values
(
	${seq:nextval@seq_cc_enter_stock},
	${fld:storageid},
	${fld:remark},
	1,
    {ts'${def:timestamp}'},
    '${def:user}',
	${def:org}
)
