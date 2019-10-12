insert into t_attachment_files(
	tuid,
	file_name,
	file_type,
	file_path,
	
	created,
	createdby,
	pk_value,
	table_code,
	org_id
) values(
	${seq:nextval@seq_t_attachment_files},
	${field_name},
	'image/png',
	${file_path},
	
	
	{ts '${def:timestamp}'},
	'${def:user}',
	${fld:customercode},
	'cc_customer',
	${def:org}
)
