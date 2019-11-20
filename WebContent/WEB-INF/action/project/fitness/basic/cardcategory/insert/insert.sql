insert into cc_position
(
   code,
   posname,
   createdby,
   created,
   org_id
)
values 
(
	${seq:nextval@seq_cc_position},
    ${fld:vc_name},
    '${def:user}',
	{ts '${def:timestamp}'},
	  ${def:org}
)
