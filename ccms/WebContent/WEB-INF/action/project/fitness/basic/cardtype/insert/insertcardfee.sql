insert into cc_cardtype_fee
(
   cardtype,
   cardfee,
   minfee,
   org_id
)
values 
(
	${seq:currval@seq_cc_cardtype},
    ${fld:vc_cardfee},
    ${fld:vc_minfee},
	${def:org}
)
