INSERT INTO cc_message(
	tuid
	,issystem
	,templateid
	,senduser
	,sendusername
	,recuser
	,recusername
	,content
	,status
	,remind
	,sendtime
	,viewtime
	,org_id
) 
SELECT 
	nextval('seq_cc_message')
	,1
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'HYK_SJSK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,t.customercode
	,c.name
	,(
		/* 办办理了升级业务，新升级的卡种是$$卡种名称$$，开始正式应用， */
		SELECT replace(m.content, '$$卡种名称$$',
				(SELECT d.name FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id)
		) FROM cc_msg_template m WHERE m.templatecode = 'HYK_SJSK' AND m.status = 1 LIMIT 1
	)	-- content
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'HYK_SJSK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
