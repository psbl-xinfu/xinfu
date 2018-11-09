UPDATE cc_contract
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,recommendcode = ${fld:recommendcode}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		COALESCE(get_arr_value(relatedetail,0),''),';;'
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
		,COALESCE(get_arr_value(relatedetail,13),''),';;',COALESCE(${fld:campaigncode},''),';',COALESCE(${fld:discountmoney},0.00),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';;',COALESCE(${fld:stage_times},1),';0;',COALESCE(${fld:stagemoney},0.00)
	)
	,inimoney = ${fld:inimoney}
	,normalmoney = ${fld:normalmoney}
	,stage_times = COALESCE(${fld:stage_times},1)
	,stagemoney = ${fld:stagemoney}
	,campaigncode = ${fld:campaigncode}
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
