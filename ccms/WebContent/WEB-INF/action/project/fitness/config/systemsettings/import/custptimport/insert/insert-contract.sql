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
	,source
	,collectby
	,collectdate
	,collecttime
	,billcode
	,factmoney
	,pay_detail
) VALUES(
	${fld:contractcode}
	,0
	,2
	,31
	,2
	,${fld:salemember}
	,${fld:salemember1}
	,0
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,${fld:customercode}
	,concat(
		${fld:customercode},';',${fld:ptlevelcode},';',${fld:ptcount},';',${fld:ptenddate}::varchar,';'
		,${fld:ptfee},';','${def:org}',';',COALESCE(${fld:salemember1},''),';',${fld:salemember},';',${fld:pt},';'
		,(SELECT name FROM hr_staff WHERE userlogin = ${fld:pt} AND org_id = ${def:org}),';',${fld:source},
		';;',${fld:money},';',${fld:ptamount},';')
	,${fld:money}
	,${fld:money}-${fld:ptamount}
	,${fld:remark}
	,${def:org}
	,${fld:source}
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,${fld:financecode}
	,${fld:money}-${fld:ptamount}
	,concat('0;0;0;', (${fld:money}-${fld:ptamount}),';0;0;0;')
)