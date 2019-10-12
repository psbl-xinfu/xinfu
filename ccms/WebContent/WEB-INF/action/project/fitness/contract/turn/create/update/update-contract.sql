UPDATE cc_contract t 
SET 
	salemember = ${fld:salemember}
	,salemember1 = ${fld:salemember1}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
	,relatedetail = concat(
		(case when ${fld:custtype}='1' then ${fld:newcustcode} else null end),';',${fld:cardcode},';',COALESCE(get_arr_value(t2.relatedetail,2),''),';'
		,get_arr_value(t2.relatedetail,3),';',get_arr_value(t2.relatedetail,4),';',COALESCE(t2.startdate::varchar,''),';',COALESCE(t2.enddate::varchar,''),';'
		,COALESCE(get_arr_value(t2.relatedetail,7),''),';',COALESCE(get_arr_value(t2.relatedetail,8),'0'),';',t2.starttype,';'
		,COALESCE(t2.totalday,0),';',COALESCE(t2.giveday,0),';'
		,COALESCE(t2.count,0),';;;;;',COALESCE(${fld:normalmoney},0.00),';'
		,COALESCE(${fld:salemember1},''),';',COALESCE(${fld:salemember},''),';'
		,${fld:customercode},';;;;',COALESCE(${fld:cardcontractcode},''),';',COALESCE(t2.enddate::varchar,''),';'
		,COALESCE(t2.nowcount,0),';',COALESCE((SELECT c.mc FROM cc_customer c WHERE c.code = t.customercode AND c.org_id = t.org_id LIMIT 1),''),';;'
	)
	,customercode = (case when ${fld:custtype}='1' then ${fld:newcustcode} else null end)
	,guestcode = (case when ${fld:custtype}='0' then ${fld:newcustcode} else null end)
	,inimoney = ${fld:normalmoney}
	,normalmoney = ${fld:normalmoney}
	,remark = ${fld:remark} 
FROM (
	SELECT 
		t1.code,
		t1.relatedetail,
		d.startdate,
		d.enddate,
		d.starttype,
		d.totalday,
		d.giveday,
		d.count,
		d.nowcount 
	FROM cc_contract t1 
	LEFT JOIN cc_card d ON t1.code = d.contractcode AND t1.org_id = d.org_id 
	WHERE t1.code = ${fld:cardcontractcode} AND t1.org_id = ${def:org}
	AND d.code = ${fld:cardcode} AND d.isgoon = 0
) AS t2
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org}
