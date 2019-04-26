insert into cc_atube(
	code,
	appid,
	remark,
	created,
	createdby,
	org_id

)VALUES(
	NEXTVAL('seq_cc_device'),
	${fld:dev_appid},
	${fld:dev_remark},
	'${def:user}',
    {ts'${def:timestamp}'},
    '${def:org}'
	

)


