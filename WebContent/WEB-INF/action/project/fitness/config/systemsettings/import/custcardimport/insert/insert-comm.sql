INSERT INTO cc_comm(
	code
	,guestcode
	,commresult --跟进状态
	,nexttime  --下次跟进时间
	,thecontactcode --联系人编号
	,remark 
	,created
	,createdby
	,org_id
) 
values
(
	nextval('seq_cc_comm'),
	${fld:guestcode},
	${fld:commresult},
	${fld:nexttime},
	${fld:thecode},
	${fld:remark},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)
