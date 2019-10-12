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
	,org_id
) 
values(
	nextval('seq_cc_message'),
	1,
	(SELECT tuid FROM cc_msg_template WHERE templatecode = 'HYK_BKSK' AND status = 1 LIMIT 1),
	'${def:user}',
	(SELECT name FROM hr_staff WHERE userlogin = '${def:user}' AND org_id = ${def:org}),
	${fld:custcode},
	${fld:name},
	(
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
					(SELECT d.name FROM cc_cardtype d WHERE d.code = ${fld:cardtype} AND d.org_id = ${def:org})
				),
				'$$会籍名称$$',
				(SELECT hf.name FROM hr_staff hf WHERE hf.userlogin = ${fld:mc} AND hf.org_id = ${def:org} LIMIT 1)
			) 
		FROM cc_msg_template m WHERE m.templatecode = 'HYK_BKSK' AND m.status = 1 LIMIT 1
	),
	1,
	(SELECT remind FROM cc_msg_template WHERE templatecode = 'HYK_BKSK' AND status = 1 LIMIT 1),
	${fld:created}::timestamp,
	${def:org}
)
