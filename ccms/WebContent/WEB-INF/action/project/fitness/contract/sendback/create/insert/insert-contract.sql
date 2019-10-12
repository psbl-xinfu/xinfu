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
	,org_id
) VALUES(
	${fld:newcontractcode}
	,0
	,4
	,1
	,1
	,${fld:salemember}
	,NULL
	,0
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,${fld:customercode}
	,concat(
		${fld:customercode},';',${fld:cardcode},';',${fld:cardcontractcode},';',COALESCE(${fld:usedays},0),';'
		,${fld:oldinimoney}::varchar,';',${fld:oldnormalmoney}::varchar,';'
		,COALESCE(${fld:leftmoney},0.00)::varchar,';',COALESCE(${fld:moneyleft},0.00)::varchar,';'
		,COALESCE(${fld:normalmoney},0.00),';',${fld:salemember}
	)
	,${fld:normalmoney}
	,${fld:normalmoney}
	,${fld:remark}
	,${def:org}
)