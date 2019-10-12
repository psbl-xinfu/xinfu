SELECT
	c.name as vc_name
	,d.code AS vc_cardcode
	,c.code as vc_customercode 
FROM cc_customer c 
LEFT JOIN cc_card d ON c.code = d.customercode AND d.isgoon = 0 and d.status != 0
	and c.org_id = d.org_id
WHERE (c.name = ${fld:vc_code} OR d.code = ${fld:vc_code} OR c.code = ${fld:vc_code} OR c.mobile = ${fld:vc_code}
	OR exists (
		select 1 from cc_cardcode cc where d.code = cc.cardcode and cc.org_id = ${def:org}
		and cc.tuid = ${fld:vc_code} and cc.status = 1
	)
)
AND c.org_id = ${def:org}