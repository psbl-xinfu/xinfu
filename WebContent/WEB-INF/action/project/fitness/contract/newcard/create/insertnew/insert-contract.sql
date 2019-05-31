INSERT INTO cc_contract(
	code
	,contracttype
	,type
	,poptype
	,status
	,salemember
	,salemember1
	,isaudit
	,createdby
	,createdate
	,createtime
	,customercode
	,relatedetail
	,inimoney
	,normalmoney
	,remark
	,recommendcode
	,org_id
	,source
	,stage_times
	,stage_times_pay
	,stagemoney
	,campaigncode
	,guestcode
) VALUES(
	${fld:newcontractcode}
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
	,1
	,${fld:salemember}
	,${fld:salemember1}
	,(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_cardtype_fee WHERE cardtype = ${fld:cardtype} AND org_id = ${def:org} AND ${fld:normalmoney} < COALESCE(minfee,0)  
		) THEN 1 ELSE 0 END
	)
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,(case when (select count(*) from cc_customer where guestcode=${fld:guestcode} and org_id=${def:org})>0 then  (select code from cc_customer where guestcode=${fld:guestcode} and org_id=${def:org}) else concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) end) 
	,concat(
		(case when (select count(*) from cc_customer where guestcode=${fld:guestcode} and org_id=${def:org})>0 then  (select code from cc_customer where guestcode=${fld:guestcode} and org_id=${def:org}) else concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) end),';;'
		,(
			SELECT c1.param_value FROM cc_config c1 
			WHERE category = 'MemberRank' AND c1.param_text = '普通会员' AND c1.org_id = (
				case when NOT EXISTS(
					SELECT 1 FROM cc_config c2 WHERE c2.org_id = ${def:org} AND c2.category = c1.category 
				) THEN (
					SELECT org_id FROM hr_org WHERE (pid is null OR pid = 0)
				) else ${def:org} END
			)
		),';'
		,${fld:cardtype},';',COALESCE(${fld:inimoney},0.00),';',COALESCE(${fld:startdate}::varchar,''),';',COALESCE(${fld:enddate}::varchar,''),';'
		,(SELECT name FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';',COALESCE(${fld:ptcount},0),';',${fld:starttype},';'
		,COALESCE(${fld:daycount},0),';',COALESCE(${fld:giveday},0),';'
		,(SELECT COALESCE(count,0) FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';'
		,COALESCE(${fld:guestcode},''),';;',COALESCE(${fld:campaigncode},''),';',COALESCE(${fld:discountmoney},0.00),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';;',COALESCE(${fld:stage_times},1),';0;',COALESCE(${fld:stagemoney},0.00)
	)
	,${fld:inimoney}
	,${fld:normalmoney}
	,${fld:remark}
	,${fld:recommendcode}
	,${def:org}
	,NULL
	,COALESCE(${fld:stage_times},1)
	,(CASE WHEN ${fld:stage_times} >= 2 THEN 1 ELSE 0 END)
	,${fld:stagemoney}
	,${fld:campaigncode}
	,${fld:guestcode}
)