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
    weight,
    num,
    custfeel,
    status,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_trainplan_detail},
	${fld:traincode},
	${fld:customercode},
	${fld:ptid},
	${fld:action},
	${fld:trainingsite},
	${fld:largecategories},
	(select actions from cc_train_actions where code = ${fld:action} and org_id = ${def:org}),
	${fld:details},
	${fld:group},
	${fld:heavynum},
	${fld:num},
	${fld:sense},
    1,
	'${def:user}',
	'${def:timestamp}',
    ${def:org}
)
