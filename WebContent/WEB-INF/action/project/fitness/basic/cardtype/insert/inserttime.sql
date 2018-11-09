insert into cc_cardtype_timelimit
(
   cardtype,
   weekday,
   starttime1,
   endtime1,
   org_id
)
values 
(
	${seq:currval@seq_cc_cardtype},
    ${fld:weekday},
    ${fld:starttime1},
    ${fld:endtime1},
	${def:org}
)
