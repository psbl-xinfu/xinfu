insert into cc_message
(
	tuid,
	senduser,
	recuser,
	content,
	status,
	org_id
)
values 
(
	${seq:nextval@seq_cc_message},
	'${def:user}',
	${fld:customercode},
	concat(${fld:cardcode}, ';', ${fld:adjourndays}, ';', '延期'),
	1,
	${def:org}
)
