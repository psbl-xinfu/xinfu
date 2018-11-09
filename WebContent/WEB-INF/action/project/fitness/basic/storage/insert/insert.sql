insert into cc_storage
(
	tuid,
	storage_name,
	status,
	address,
	org_id
)
values
(
	${seq:nextval@seq_cc_storage},
	${fld:storage_name},
	${fld:status},
	${fld:address},
	${def:org}
)
