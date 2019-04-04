insert into cc_device(
	code,
	deviceid,
	appid,
	type,
	status,
	remark,
	created,
	createdby,
	org_id

)VALUES(
	NEXTVAL('seq_cc_device'),
	${fld:dev_deviceid},
	${fld:dev_appid},
	3,
	${fld:dev_status},
	${fld:dev_remark},
	'${def:user}',
    {ts'${def:timestamp}'},
    '${def:org}'
	

)


