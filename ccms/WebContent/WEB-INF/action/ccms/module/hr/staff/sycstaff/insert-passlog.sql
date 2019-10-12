insert into ${schema}s_passlog  
(
	passlog_id,
	last_change,
	hash,
	user_id
)
values 
(
	cast(${seq:nextval@${schema}seq_passlog} as int),
	{d '${def:date}'},
	'${fld:hash}',
	cast(${fld:user_id} as int)
)
