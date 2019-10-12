insert into cc_cardtype_fee
(
   cardtype,
   cardfee,
   minfee,
   remark,
   org_id
)
values 
(
	${seq:currval@seq_cc_cardtype},
    ${fld:cardfee},
    ${fld:minfee},
    ${fld:remark},
	${def:org}
)
