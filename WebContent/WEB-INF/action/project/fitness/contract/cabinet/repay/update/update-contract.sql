UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',get_arr_value(relatedetail,1),';',get_arr_value(relatedetail,2),';',get_arr_value(relatedetail,3),';'
		,get_arr_value(relatedetail,4),';',COALESCE(get_arr_value(relatedetail,5),'0'),';',get_arr_value(relatedetail,6),';',get_arr_value(relatedetail,7),';'
		,COALESCE(${fld:salemember1},''),';',${fld:salemember},';',get_arr_value(relatedetail,10)
	)
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
