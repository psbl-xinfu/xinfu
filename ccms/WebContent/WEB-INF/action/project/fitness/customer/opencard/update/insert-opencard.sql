insert into cc_opencard
(
	tuid,
	cardcode,
	customercode,
	old_startdate,
	old_enddate,
	startdate,
	enddate,
	remark,
	status,
	createdby,
	created,
	org_id
)
 
(
	select 
		${seq:nextval@seq_cc_opencard},
	    card.code,
	    card.customercode,
	    card.startdate,
	    card.enddate,
	    '${def:date}',
	    '${def:date}'::date+(select daycount from cc_cardtype where code = card.cardtype and org_id = ${def:org}),
	    null,
	    1,
		'${def:user}',
	    {ts'${def:timestamp}'},
	    ${def:org}
	from cc_card card
	where card.status=2 and card.isgoon =0 and card.starttype = 2 and card.org_id = ${def:org}
	and card.code = ${fld:cardcode}
)
