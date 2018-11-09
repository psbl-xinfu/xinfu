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
	${seq:nextval@seq_cc_message},
	1,
	(SELECT tuid FROM cc_msg_template WHERE templatecode = 'SJ_GKSK' AND status = 1 LIMIT 1),
	'${def:user}',
	(SELECT name FROM hr_staff WHERE userlogin = '${def:user}' AND org_id = ${def:org}),
	${fld:customercode},
	(select name from cc_customer where code = ${fld:customercode} and org_id = ${def:org}),
	(
		/* 办理私教合同，购买$$教练名称$$教练的$$课程级别$$的$$课程节数$$节课 */
		SELECT 
			replace(
				replace(
					replace(
						m.content, 
						'$$教练名称$$', 
						(SELECT hf.name FROM hr_staff hf WHERE hf.userlogin = ${fld:salemember} AND hf.org_id = ${def:org})
					),
					'$$课程级别$$',
					(SELECT d.ptlevelname FROM cc_ptdef d WHERE d.code = ${fld:ptlevelcode} AND d.org_id = ${def:org})
				),
				'$$课程节数$$',
				'${fld:ptcount}'
			) 
		FROM cc_msg_template m WHERE m.templatecode = 'SJ_GKSK' AND m.status = 1 LIMIT 1
	),
	1,
	(SELECT remind FROM cc_msg_template WHERE templatecode = 'SJ_GKSK' AND status = 1 LIMIT 1),
	{ts '${def:timestamp}'},
	${def:org}
)
