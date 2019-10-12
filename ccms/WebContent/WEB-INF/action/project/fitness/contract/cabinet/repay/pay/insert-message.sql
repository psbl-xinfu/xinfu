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
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'MP_ZGHK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,t.customercode
	,c.name
	,(
		/* 租柜合同$$合同编号$$补齐余款$$还款金额$$ */
		SELECT replace(replace(m.content, '$$还款金额$$', t.normalmoney::varchar), '$$合同编号$$', t.code) 
		FROM cc_msg_template m WHERE m.templatecode = 'MP_ZGHK' AND m.status = 1 LIMIT 1
	)
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'MP_ZGHK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
