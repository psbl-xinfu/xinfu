INSERT INTO cc_finance(
	code
	,cardcode
	,customercode
	,operatelogcode
	,operationcode
	,salesman
	,type
	,item
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
	${fld:cardcode},
	${fld:custcode},
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''), lpad(nextval('seq_cc_operatelog')::varchar, 8, '0')),
	${fld:contractcode},
	${fld:mc},
	1,
	10,
	(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),
	(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),
	0,
	${fld:remark},
	'${def:user}',
	${fld:created}::timestamp,
	1,
	concat('0;0;0;', (case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),';0;0;0;'),
	${def:org}
)
