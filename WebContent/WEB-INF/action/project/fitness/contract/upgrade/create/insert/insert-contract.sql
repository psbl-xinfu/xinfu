--modified by zzn 修改 d.isgoon='0'
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
) 
SELECT 
	${fld:newcontractcode}
	,1
	,type
	,poptype
	,1
	,${fld:salemember}
	,${fld:salemember1}
	,(
		CASE WHEN EXISTS(
			SELECT 1 FROM cc_cardtype_fee f WHERE f.cardtype = ${fld:cardtype} AND f.org_id = ${def:org} AND ${fld:normalmoney}+t.normalmoney < COALESCE(f.minfee,0)  
		) THEN 1 ELSE 0 END
	)
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,customercode
	,concat(
		customercode,';',${fld:cardcode},';',COALESCE(get_arr_value(relatedetail,2),''),';'
		,${fld:cardtype},';',COALESCE(${fld:inimoney},0.00),';',COALESCE(${fld:startdate}::varchar,''),';',COALESCE(${fld:enddate}::varchar,''),';'
		,(SELECT name FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';',COALESCE(${fld:ptcount},0),';',get_arr_value(relatedetail,9),';'
		,COALESCE(${fld:daycount},0),';',COALESCE(${fld:giveday},0),';'
		,(SELECT COALESCE(count,0) FROM cc_cardtype WHERE code = ${fld:cardtype} AND org_id = ${def:org} LIMIT 1),';;'
		,get_arr_value(relatedetail,3),';',COALESCE(${fld:campaigncode},''),';',COALESCE(${fld:discountmoney},0.00),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';;1;0;0.00;',${fld:cardcontractcode},';',(
			select concat(COALESCE(d.enddate::varchar,''),';', COALESCE(d.nowcount,0)) from cc_card d where d.code = ${fld:cardcode} and d.org_id = ${def:org} and d.isgoon='0'
		),';',COALESCE((SELECT c.mc FROM cc_customer c WHERE c.code = t.customercode AND c.org_id = t.org_id),''),';',${fld:mc},';',${fld:fillingmoney}
	)
	,${fld:inimoney}
	,${fld:normalmoney}
	,${fld:remark}
	,NULL
	,${def:org}
	,NULL
	,1
	,0
	,NULL 
	,${fld:campaigncode}
FROM cc_contract t 
WHERE code = ${fld:cardcontractcode} AND org_id = ${def:org}
