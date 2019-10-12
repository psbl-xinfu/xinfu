insert into cc_trainplan_detail_group
(
    code,
    detailcode,
    customercode,
    --groups,
    
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_trainplan_detail_group},
	${seq:currval@seq_cc_trainplan_detail},
	${fld:custcode},
	--${fld:groups},
	
	'${def:user}',
	'${def:timestamp}',
    ${def:org}
)
