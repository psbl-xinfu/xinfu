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
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'HYK_BKSK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,t.customercode
	,c.name
	,(
		/* 办理了入会合同，会员卡号：$$卡号$$，卡种：$$卡种名称$$，办卡的会籍顾问：$$会籍名称$$， */
		SELECT 
			replace(
				replace(
					replace(
						m.content, 
						'$$卡号$$', 
						${fld:cardcode}
					),
					'$$卡种名称$$',
					(SELECT d.name FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id)
				),
				'$$会籍名称$$',
				(SELECT hf.name FROM hr_staff hf WHERE hf.userlogin = get_arr_value(t.relatedetail, 19) AND hf.org_id = ${def:org} LIMIT 1)
			) 
		FROM cc_msg_template m WHERE m.templatecode = 'HYK_BKSK' AND m.status = 1 LIMIT 1
	)	-- content
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'HYK_BKSK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
AND ${fld:cardcode} IS NOT NULL AND ${fld:cardcode} != ''
