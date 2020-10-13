insert into cc_comm
(
    code,
    guestcode,
    commresult,
    thecontactcode,
    nexttime,
    remark,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_comm},
	${fld:ofcode},
	${fld:the_state},
	${fld:thecode},
	(${fld:_start_date}${fld:hour} ||':'||${fld:minute})::timestamp,
    ${fld:remark},
    '${def:user}',
    {ts'${def:timestamp}'},
    ${def:org}
)
