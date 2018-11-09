insert into cc_guest_visit 
(
    code,
    guestcode,
	contractcode,
	mc,
	visitdate,
	visittime,
	status,
	created,
	createdby,
	org_id
)
values 
(
	${seq:nextval@seq_cc_guest_visit},
	${fld:vc_code},
    ${fld:vc_contractcode},
    (select createdby from cc_contract where code=${fld:vc_contractcode} and org_id = ${def:org}),
	(select createdate from cc_contract where code=${fld:vc_contractcode} and org_id = ${def:org}),
	(select createtime from cc_contract where code=${fld:vc_contractcode} and org_id = ${def:org}),
	3,
	{ts '${def:timestamp}'},
	'${def:user}',
	${def:org}
)                        