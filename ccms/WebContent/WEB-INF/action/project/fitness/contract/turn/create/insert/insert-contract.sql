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
	,guestcode
	,relatedetail
	,inimoney
	,normalmoney
	,remark
	,org_id
	,stage_times
) 
SELECT 
	${fld:newcontractcode}
	,0
	,10
	,1
	,1
	,${fld:salemember}
	,${fld:salemember1}
	,0
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,(case when ${fld:custtype}='1' then ${fld:newcustcode} else null end)
	,(case when ${fld:custtype}='0' then ${fld:newcustcode} else null end)
	,concat(
		(case when ${fld:custtype}='1' then ${fld:newcustcode} else null end),';',${fld:cardcode},';',COALESCE(get_arr_value(relatedetail,2),''),';'
		,d.cardtype,';',get_arr_value(relatedetail,4),';',COALESCE(d.startdate::varchar,''),';',COALESCE(d.enddate::varchar,''),';'
		,(SELECT ct.name FROM cc_cardtype ct WHERE ct.code = d.cardtype AND ct.org_id = d.org_id),';',COALESCE(get_arr_value(relatedetail,8),'0'),';',d.starttype,';'
		,COALESCE(d.totalday,0),';',COALESCE(d.giveday,0),';'
		,COALESCE(d.nowcount,0),';;;;;',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';'
		,${fld:customercode},';;;;',COALESCE(${fld:cardcontractcode},''),';',COALESCE(d.enddate::varchar,''),';'
		,COALESCE(d.nowcount,0),';',COALESCE((SELECT c.mc FROM cc_customer c WHERE c.code = t.customercode AND c.org_id = t.org_id LIMIT 1),''),';;'
	)
	,${fld:normalmoney}
	,${fld:normalmoney}
	,${fld:remark}
	,${def:org}
	,1 
FROM cc_contract t 
LEFT JOIN cc_card d ON t.code = d.contractcode AND t.org_id = d.org_id 
WHERE t.code = ${fld:cardcontractcode} AND t.org_id = ${def:org}
AND d.code = ${fld:cardcode} AND d.isgoon = 0
