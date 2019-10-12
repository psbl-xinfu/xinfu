INSERT INTO cc_finance(
	code
	,customercode
	,operatelogcode
	,operationcode
	,salesman
	,type
	,item
	,ptlevelcode
	,premoney
	,money
	,moneyleft
	,remark
	,createdby
	,created
	,status
	,pay_detail
	,org_id
) 
values(
	${fld:financecode},
	${fld:customercode},
	concat((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}), ${seq:nextval@seq_cc_operatelog}),
	${fld:contractcode},
	${fld:pt},
	2,
	20,
	${fld:ptlevelcode},
	0,
	(${fld:money}-${fld:ptamount}),
	0,
	${fld:remark},
	'${def:user}',
	{ts '${def:timestamp}'},
	1,
	concat('0;0;0;', (${fld:money}-${fld:ptamount}),';0;0;0;'),
	${def:org}
)
