UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		get_arr_value(relatedetail,0),';',${fld:cabinetid},';',${fld:months},';',${fld:begindate}::varchar,';'
		,${fld:enddate}::varchar,';',${fld:deposit},';',${fld:inimoney},';',${fld:normalmoney},';'
		,COALESCE(${fld:salemember1},''),';',${fld:salemember},';',${fld:price}
	)
	,inimoney = ${fld:inimoney}
	,normalmoney = ${fld:normalmoney}
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
