INSERT INTO cc_operatelog(
	code
	,opertype
	,relatedetail
	,inimoney
	,normalmoney
	,factmoney
	,status
	,pay_detail
	,remark
	,createdby
	,createdate
	,createtime
	,pk_value
	,customercode
	,org_id
) 
values(
	concat((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}), ${seq:currval@seq_cc_operatelog}),
	(
		SELECT c1.param_value::integer FROM cc_config c1 
		WHERE category = 'OpeCategory' AND param_text = '本店购买PT课' and c1.org_id = (
			case when not exists(
				select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
			) then (
				select org_id from hr_org where (pid is null or pid = 0)
			) else ${def:org} end
		) limit 1
	),
	concat(${fld:customercode},';',${fld:salemember}),
	${fld:money},
	(${fld:money}-${fld:ptamount}),
	(${fld:money}-${fld:ptamount}),
	1,
	concat('0;0;0;', (${fld:money}-${fld:ptamount}),';0;0;0;'),
	${fld:remark},
	'${def:user}',
	'${def:date}',
	'${def:time}',
	${fld:contractcode},
	${fld:customercode},
	${def:org}
)
