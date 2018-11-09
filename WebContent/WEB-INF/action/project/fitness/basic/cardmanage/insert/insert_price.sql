insert into cc_cardtype_fee
(
	cardtype,
	cardfee,
	org_id
)
values
(
	${seq:currval@seq_cc_cardtype},
	${fld:f_cardfee},
	${def:org}
)