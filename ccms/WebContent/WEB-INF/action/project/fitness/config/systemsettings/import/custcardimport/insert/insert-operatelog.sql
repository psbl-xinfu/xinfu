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
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''), lpad(currval('seq_cc_operatelog')::varchar, 8, '0')),
	(
		SELECT c1.param_value::integer FROM cc_config c1 
		WHERE category = 'OpeCategory' AND param_text = '办卡' and c1.org_id = (
			case when not exists(
				select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
			) then (
				select org_id from hr_org where (pid is null or pid = 0)
			) else ${def:org} end
		) limit 1
	),
	concat(${fld:custcode},';',${fld:cardcode}),
	(select cardfee from cc_cardtype_fee where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1),
	(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),
	(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),
	1,
	concat('0;0;0;', (case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),';0;0;0;'),
	${fld:remark},
	'${def:user}',
	${fld:created}::date,
	to_char(${fld:created}::timestamp, 'hh24:mi:ss')::time,
	${fld:contractcode},
	${fld:custcode},
	${def:org}
)
