UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',get_arr_value(relatedetail,1),';'
		,get_arr_value(relatedetail,2),';'
		,get_arr_value(relatedetail,3),';',COALESCE(${fld:inimoney},0.00),';',COALESCE(get_arr_value(relatedetail,5),''),';',COALESCE(get_arr_value(relatedetail,6),''),';'
		,get_arr_value(relatedetail,7),';',get_arr_value(relatedetail,8),';',get_arr_value(relatedetail,9),';'
		,get_arr_value(relatedetail,10),';',get_arr_value(relatedetail,11),';',get_arr_value(relatedetail,12),';'
		,get_arr_value(relatedetail,13),';;',get_arr_value(relatedetail,15),';',get_arr_value(relatedetail,16),';',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';;',get_arr_value(relatedetail,21),';',COALESCE(${fld:current_stage_times_pay},0),';',COALESCE(${fld:stagemoney},0.00)
	)
	,inimoney = ${fld:inimoney}
	,normalmoney = ${fld:normalmoney}
	,stagemoney = ${fld:stagemoney}
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
