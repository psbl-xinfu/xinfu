insert into ${schema}s_user 
(
	user_id,
	userlogin,
	passwd,
	fname,
	enabled,
	locale,
	pwd_policy
)
values 
(
	${seq:nextval@${schema}seq_user},
	${fld:userlogin},
	${fld:passwd},
	${fld:name},
	1,
	'cn',
	'-2'
)