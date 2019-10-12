UPDATE cc_contract 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,recommendcode = ${fld:recommendcode}
	,source = ${fld:channel}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		customercode,';',${fld:ptlevelcode},';',${fld:ptcount},';',${fld:ptenddate}::varchar,';'
		,${fld:ptfee},';','${def:org}',';',COALESCE(${fld:salemember1},''),';',${fld:salemember},';',${fld:pt},';'
		,(SELECT name FROM hr_staff WHERE userlogin = ${fld:pt} AND org_id = ${def:org}),';',${fld:channel},';'
		,COALESCE(${fld:recommendcode},''),';',${fld:normalmoney}
	)
	,inimoney = ${fld:normalmoney}
	,normalmoney = ${fld:normalmoney}
	,remark = ${fld:remark} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
