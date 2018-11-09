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
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'HYK_ZKSK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,(case when t.customercode is null 
			then concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) else 
			t.customercode
			end)
	,(case when c.name is null then guest.name else c.name end)
	,(
		/* 办理转卡业务，该会员卡转由他人使用， */
		SELECT m.content FROM cc_msg_template m WHERE m.templatecode = 'HYK_ZKSK' AND m.status = 1 LIMIT 1
	)	-- content
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'HYK_ZKSK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
left join cc_guest guest on t.guestcode = guest.code and guest.org_id = t.org_id
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
