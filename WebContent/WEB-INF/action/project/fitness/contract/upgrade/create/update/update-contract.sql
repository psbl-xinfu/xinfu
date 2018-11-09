UPDATE cc_contract t 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		get_arr_value(t.relatedetail,0),';',get_arr_value(t.relatedetail,1),';',COALESCE(get_arr_value(t.relatedetail,2),''),';'
		,${fld:cardtype},';',COALESCE(${fld:inimoney},0.00),';',COALESCE(${fld:startdate}::varchar,''),';',COALESCE(${fld:enddate}::varchar,''),';'
		,(SELECT name FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';',COALESCE(${fld:ptcount},0),';',get_arr_value(t.relatedetail,9),';'
		,COALESCE(${fld:daycount},0),';',COALESCE(${fld:giveday},0),';'
		,(SELECT COALESCE(count,0) FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';;'
		,get_arr_value(t2.relatedetail,3),';',COALESCE(${fld:campaigncode},''),';',COALESCE(${fld:discountmoney},0.00),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';;1;0;0.00;',${fld:cardcontractcode},';',(
			select concat(COALESCE(d.enddate::varchar,''),';', COALESCE(d.nowcount,0)) from cc_card d where d.code = ${fld:cardcode} and d.org_id = ${def:org}
		),';',COALESCE((SELECT c.mc FROM cc_customer c WHERE c.code = t.customercode AND c.org_id = t.org_id),''),';',${fld:mc},';',${fld:fillingmoney}
	)
	,inimoney = ${fld:inimoney}
	,normalmoney = ${fld:normalmoney}
	,isaudit = (case when isaudit=2 or isaudit=3 then isaudit else (
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_cardtype_fee f WHERE f.cardtype = ${fld:cardtype} AND f.org_id = ${def:org} AND ${fld:normalmoney}+t2.normalmoney < COALESCE(f.minfee,0) 
		) THEN 1 ELSE 0 END
	) end)
	,campaigncode = ${fld:campaigncode}
	,remark = ${fld:remark} 
FROM (
	SELECT 
		code
		,type
		,poptype
		,normalmoney
		,customercode 
		,relatedetail 
	FROM cc_contract 
	WHERE code = ${fld:cardcontractcode} AND org_id = ${def:org}
) AS t2 
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org}
