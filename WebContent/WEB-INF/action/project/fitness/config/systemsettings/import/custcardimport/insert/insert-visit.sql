insert into cc_guest_visit(
	code,
	guestcode,
	contractcode,
	visitdate,
	visittime,
	mc,
	status,
	remark,
	createdby,
	created,
	org_id,
	posptid
)
values
(
	${seq:nextval@seq_cc_guest_visit},
	${seq:currval@seq_cc_guest},
	${fld:contractcode},
	${fld:created}::date,
	to_char(${fld:created}::timestamp, 'hh24:mi:ss')::time,
	${fld:mc},
	3,
	${fld:remark},
	'${def:user}',
	${fld:created}::timestamp,
	${def:org},
	${fld:pt}
)

