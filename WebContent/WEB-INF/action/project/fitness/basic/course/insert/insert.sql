insert into cc_course
(
   code,
   courname,
   isgood,
   createdby,--操作人
   created,
   org_id,
   status
)
values 
(
	${seq:nextval@seq_cc_cardtype},
    ${fld:vc_name},
    ${fld:isgood},
    '${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	1
)