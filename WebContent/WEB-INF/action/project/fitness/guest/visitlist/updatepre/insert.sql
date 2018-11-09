insert into cc_guest_visit 
(
	code,
    guestcode,
	preparecode,
	contractcode,
	mc,
	remark,
	visitdate,
	visittime,
	posptid,
	status,
	created,
	createdby,
	org_id
)
values 
(
	${seq:nextval@seq_cc_guest_visit},
	${fld:vc_guestcode},
    ${fld:tuid},
    ${fld:vc_contractcode},
    ${fld:vc_mc},
    ${fld:vc_remark},
	{ts '${def:timestamp}'}::date,
	{ts '${def:timestamp}'}::time,
	${fld:posptid},
	1,
	{ts '${def:timestamp}'},
	'${def:user}',
	${def:org}
)