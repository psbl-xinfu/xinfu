INSERT INTO cc_comm(
	code
	,guestcode
	,commresult --跟进状态
	,thecontactcode --联系人编号
	,remark 
	,createdby
	,created
	,org_id
) 
values
(
	nextval('seq_cc_comm')
	,${fld:guestcode}
	,${fld:commresult}
	,${fld:thecode}
	,${fld:remark}
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org}
)
