INSERT INTO cc_comm(
	code
	,guestcode
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
	,${fld:thecode}
	,${fld:remark}
	,'${def:user}'
	,${fld:created}
	,${def:org}
)
