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
	,(SELECT tuid FROM cc_msg_template WHERE templatecode = 'HYK_HKSK' AND status = 1 LIMIT 1)	-- remind
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}')
	,t.customercode
	,c.name
	,(
		/* 合同补款$$还款金额$$，尚欠$$欠款金额$$，主合同$$合同编号$$。会员卡号：$$卡号$$，卡种：$$卡种名称$$，会籍：$$会籍名称$$， */
		SELECT 
			replace(
				replace(
					replace(
						replace(
							replace(
								replace(m.content, '$$合同编号$$', t.relatecode), 
								'$$欠款金额$$', 
								(select t2.normalmoney - t2.factmoney - t.normalmoney - COALESCE((
									select sum(t3.factmoney) from cc_contract t3 where t3.relatecode = t2.relatecode 
									and t3.code != t.code and t3.status >= 2
								),0.00) from cc_contract t2 where t2.code = t.relatecode and t2.status != 0 and t2.isaudit != 3)::varchar
							), 
							'$$还款金额$$',
							${fld:factmoney}::varchar
						), 
						'$$卡号$$', 
						get_arr_value(t.relatedetail, 1)
					),
					'$$卡种名称$$',
					(SELECT d.name FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id)
				),
				'$$会籍名称$$',
				(SELECT hf.name FROM hr_staff hf WHERE hf.userlogin = get_arr_value(t.relatedetail, 19) AND hf.org_id = ${def:org} LIMIT 1)
			) 
		FROM cc_msg_template m WHERE m.templatecode = 'HYK_HKSK' AND m.status = 1 LIMIT 1
	)	-- content
	,1
	,(SELECT remind FROM cc_msg_template WHERE templatecode = 'HYK_HKSK' AND status = 1 LIMIT 1)	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id  
FROM cc_contract t 
LEFT JOIN cc_customer c ON c.code = t.customercode AND c.org_id = t.org_id 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org} 
