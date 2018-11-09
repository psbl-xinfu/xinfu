insert into cc_customer(
	code,
	guestcode,
	name,
	urgent,
	mobile,
	status,
	remark,
	mc,
	indate,
	salemember,
	sex,
	cardtype,
	card,
	createdby,
	created,
	org_id
) 
values
(
	${fld:custcode},
	${seq:currval@seq_cc_guest},
	${fld:name},
	${fld:othertel},
	${fld:mobile},
	1,	/** status，未付款前默认无效*/
	${fld:remark},	-- remark
	${fld:mc},	-- mc
	${fld:created}::date,	-- indate
	${fld:mc},	-- salemember
	${fld:sex},
	${fld:idcardtype},
	${fld:idcard},
	'${def:user}',
	${fld:created}::timestamp,
	${def:org} 
)

