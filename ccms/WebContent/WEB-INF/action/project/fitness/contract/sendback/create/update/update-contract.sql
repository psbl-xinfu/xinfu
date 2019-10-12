UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',${fld:cardcode},';',${fld:cardcontractcode},';',COALESCE(${fld:usedays},0),';'
		,${fld:oldinimoney}::varchar,';',${fld:oldnormalmoney}::varchar,';'
		,COALESCE(${fld:leftmoney},0.00)::varchar,';',COALESCE(${fld:moneyleft},0.00)::varchar,';'
		,COALESCE(${fld:normalmoney},0.00),';',${fld:salemember}
	)
	,inimoney = ${fld:normalmoney}
	,normalmoney = ${fld:normalmoney}
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
