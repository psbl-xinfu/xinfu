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
	,relatecode
	,org_id
) 
SELECT 
	${fld:newcontractcode}
	,3
	,1
	,15
	,1
	,${fld:salemember}
	,${fld:salemember1}
	,0
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,customercode
	,concat(
		customercode,';',get_arr_value(relatedetail,1),';',get_arr_value(relatedetail,2),';',get_arr_value(relatedetail,3),';'
		,get_arr_value(relatedetail,4),';',COALESCE(get_arr_value(relatedetail,5),'0'),';',get_arr_value(relatedetail,6),';',get_arr_value(relatedetail,7),';'
		,COALESCE(${fld:salemember1},''),';',${fld:salemember},';',get_arr_value(relatedetail,10)
	)
	,normalmoney
	,normalmoney - factmoney
	,${fld:remark}
	,code
	,org_id 
FROM cc_contract 
WHERE code = ${fld:relatecode} AND org_id = ${def:org} 
