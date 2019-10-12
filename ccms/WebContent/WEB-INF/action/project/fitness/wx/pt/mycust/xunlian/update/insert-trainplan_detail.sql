insert into cc_trainplan_detail
(
    code,
    trainplancode,
    customercode,
    ptid,
    
    actionscode,
    train_part,
    apparatus,
    actions,
    train_detail_part,
    
    groups,
    status,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_trainplan_detail},
	${fld:traincode},
	${fld:custcode},
	${fld:ptid},
	
	${fld:action1},
	${fld:trainingsite1},
	${fld:largecategories1},
	(select actions from cc_train_actions where code = ${fld:action1} and org_id = ${def:org}),
	${fld:details1},
	
	${fld:group},
    1,
	'${def:user}',
	'${def:timestamp}',
    ${def:org}
)
