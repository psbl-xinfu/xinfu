UPDATE cc_contract t 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',${fld:cardcode},';',COALESCE(get_arr_value(relatedetail,2),''),';'
		,${fld:cardtype},';',COALESCE(${fld:inimoney},0.00),';',COALESCE(${fld:startdate}::varchar,''),';',COALESCE(${fld:enddate}::varchar,''),';'
		,(SELECT name FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';',COALESCE(${fld:ptcount},0),';',${fld:starttype},';'
		,COALESCE(${fld:daycount},0),';',COALESCE(${fld:giveday},0),';'
		,(SELECT COALESCE(count,0) FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';;'
		,COALESCE((SELECT d.enddate::varchar FROM cc_card d WHERE d.code = ${fld:cardcode} AND d.contractcode = ${fld:cardcontractcode} AND d.org_id = t.org_id),''),';'
		,COALESCE(${fld:campaigncode},''),';',COALESCE(${fld:discountmoney},0.00),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';',COALESCE(${fld:cardcontractcode},''),';'
		,COALESCE((SELECT c.mc FROM cc_customer c WHERE c.code = t.customercode AND c.org_id = t.org_id),''),';',${fld:mc}
	)
	,inimoney = ${fld:inimoney}
	,normalmoney = ${fld:normalmoney}
	,isaudit = (case when isaudit=2 or isaudit=3 then isaudit else (
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_cardtype_fee f WHERE f.cardtype = ${fld:cardtype} AND f.org_id = ${def:org} AND ${fld:normalmoney} < COALESCE(f.minfee,0) 
		) THEN 1 ELSE 0 END
	) end)
	,campaigncode = ${fld:campaigncode}
	,remark = ${fld:remark} 
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org}
