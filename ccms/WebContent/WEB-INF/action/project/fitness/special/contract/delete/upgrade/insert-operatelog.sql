INSERT INTO cc_operatelog(
	code
	,org_id
	,opertype
	,relatedetail
	,inimoney
	,normalmoney
	,factmoney
	,status
	,createdate
	,createtime
	,createdby
) 
SELECT
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'') || lpad(nextval('seq_cc_operatelog')::varchar, 8, '0')
	,t.org_id
	,(SELECT config.param_value FROM cc_config config WHERE
	config.category = 'OpeCategory' AND config.param_text = '删除已收款合同' AND config.status = 1 and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))
	,${fld:vc_code}
	,0
	,0
	,0
	,1
	,'${def:date}'
	,'${def:time}'
	,'${def:user}'
FROM cc_contract t 
WHERE t.code = ${fld:vc_code} and t.org_id = ${def:org}
