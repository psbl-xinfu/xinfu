INSERT INTO cc_contract(
	code
	,contracttype
	,type
	,poptype
	,status
	,salemember
	,isaudit
	,createdby
	,createdate
	,createtime
	,customercode
	,relatedetail
	,inimoney
	,normalmoney
	,remark
	,org_id
	,source
	,guestcode
	,collectby
	,collectdate
	,collecttime
	,billcode
	,factmoney
	,pay_detail
) VALUES(
	${fld:contractcode}
	,0
	,(
		SELECT c1.param_value::integer FROM cc_config c1 
		WHERE category = 'ContractType' AND param_text = '办卡合同' and c1.org_id = (
			case when not exists(
				select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
			) then (
				select org_id from hr_org where (pid is null or pid = 0)
			) else ${def:org} end
		) limit 1
	)
	,1
	,2
	,${fld:mc}
	,0
	,'${def:user}'
	,${fld:created}::date
	,to_char(${fld:created}::timestamp, 'hh24:mi:ss')::time
	,${fld:custcode}
	,concat(${fld:custcode},';',${fld:cardcode},';'
		,(SELECT c1.param_value FROM cc_config c1 
			WHERE category = 'MemberRank' AND c1.param_text = '普通会员' AND c1.org_id = (
				case when NOT EXISTS(
					SELECT 1 FROM cc_config c2 WHERE c2.org_id = ${def:org} AND c2.category = c1.category 
				) THEN (
					SELECT org_id FROM hr_org WHERE (pid is null OR pid = 0)
				) else ${def:org} END
			)
		),';',${fld:cardtype},';',(select cardfee from cc_cardtype_fee where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1)
		,';',COALESCE(${fld:startdate}::varchar,''),';',COALESCE(${fld:enddate}::varchar,''),';'
		,(SELECT name FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';',
		(select ptcount from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1),
		';',${fld:starttype},';',(select daycount from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1),
		';'
		,(select giveday from cc_cardtype where code = ${fld:cardtype} and org_id = ${def:org} limit 1)
		,';'
		,(SELECT COALESCE(count,0) FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1)
		,';'
		,${seq:currval@seq_cc_guest}
		,';;;'
		,(case when ${fld:cardmoney} is null then 0 else ((select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1)-${fld:cardmoney}) end)
		,';'
		,(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end)
		,';'
		,COALESCE(${fld:mc},'')
		,';;;0;'
	)
	,(select cardfee from cc_cardtype_fee where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1)
	,(case when ${fld:normalmoney} is null then (case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end) else ${fld:normalmoney} end)
	,${fld:remark}
	,${def:org}
	,NULL
	,${seq:currval@seq_cc_guest}
	,'${def:user}'
	,${fld:created}::date
	,to_char(${fld:created}::timestamp, 'hh24:mi:ss')::time
	,${fld:financecode}
	,(case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end)
	,concat('0;0;0;', (case when ${fld:cardmoney} is null then (select cardfee from cc_cardtype_fee 
		where cardtype = ${fld:cardtype} and org_id = ${def:org} limit 1) else ${fld:cardmoney} end),';0;0;0;')
)

