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
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'SJ_GKSK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,t.customercode
	,c.name
	,(
		/* 办理私教合同，购买$$教练名称$$教练的$$课程级别$$的$$课程节数$$节课 */
		SELECT 
			replace(
				replace(
					replace(
						m.content, 
						'$$教练名称$$', 
						(SELECT hf.name FROM hr_staff hf WHERE hf.userlogin = get_arr_value(t.relatedetail, 8) AND hf.org_id = t.org_id)
					),
					'$$课程级别$$',
					(SELECT d.ptlevelname FROM cc_ptdef d WHERE d.code = get_arr_value(t.relatedetail, 1) AND d.org_id = t.org_id)
				),
				'$$课程节数$$',
				get_arr_value(t.relatedetail, 2)
			) 
		FROM cc_msg_template m WHERE m.templatecode = 'SJ_GKSK' AND m.status = 1 LIMIT 1
	)	-- content
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'SJ_GKSK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
