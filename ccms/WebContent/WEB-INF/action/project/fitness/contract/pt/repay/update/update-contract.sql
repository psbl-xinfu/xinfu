UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',get_arr_value(relatedetail,1),';',get_arr_value(relatedetail,2),';',get_arr_value(relatedetail,3),';'
		,get_arr_value(relatedetail,4),';','${def:org}',';',COALESCE(${fld:salemember1},''),';',${fld:salemember},';',get_arr_value(relatedetail,8),';'
		,get_arr_value(relatedetail,9),';',source,';'
		,COALESCE(recommendcode,''),';',normalmoney
	)
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
