insert into cc_product
(
   code,
   proname,
   isgood,
   createdby,--操作人
   created,
   org_id
   
)
values 
(
	${seq:nextval@seq_cc_cardtype},
    ${fld:vc_name},
    ${fld:isgood},
    '${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)
