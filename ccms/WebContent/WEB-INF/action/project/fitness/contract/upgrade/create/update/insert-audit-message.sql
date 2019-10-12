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
	,contractcode
) 
SELECT 
	nextval('seq_cc_message')
	,2
	,NULL	-- templateid
	,'${def:user}'
	,(SELECT name FROM hr_staff WHERE userlogin = '${def:user}' AND org_id = ${def:org})
	,NULL	-- recuser
	,NULL
	,concat('您有新的待审批合同，合同编号', ${fld:contractcode})	-- content
	,1
	,1	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,t.org_id
	,t.code
FROM cc_contract t 
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} AND EXISTS(
	SELECT 1 FROM cc_cardtype_fee f
	WHERE f.cardtype = get_arr_value(t.relatedetail, 3) AND f.org_id = ${def:org} 
	AND t.normalmoney < COALESCE(f.minfee,0) 
)