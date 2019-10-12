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
	,(SELECT f.name FROM hr_staff f WHERE f.userlogin = '${def:user}' AND f.org_id = ${def:org})
	,NULL	-- recuser
	,NULL
	,concat('您有新的待审批合同，合同编号', ${fld:newcontractcode})	-- content
	,1
	,1	-- remind
	,{ts '${def:timestamp}'}
	,NULL
	,${def:org} 
	,${fld:newcontractcode}
FROM dual 
WHERE EXISTS(
	SELECT 1 FROM cc_cardtype_fee f
	WHERE f.cardtype = ${fld:cardtype} AND f.org_id = ${def:org} 
	AND ${fld:normalmoney} < COALESCE(f.minfee,0) 
)