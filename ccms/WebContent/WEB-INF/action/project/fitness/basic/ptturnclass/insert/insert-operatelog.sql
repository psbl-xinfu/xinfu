INSERT INTO cc_operatelog(
	code
	,org_id
	,opertype
	,relatedetail
	,inimoney
	,normalmoney
	,factmoney
	,status
	,pay_detail
	,remark
	,createdate
	,createtime
	,createdby
) VALUES(
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'') || lpad(nextval('seq_cc_operatelog')::varchar, 8, '0')
	,${def:org}
	,(SELECT param_value FROM cc_config WHERE category = 'OpeCategory' AND param_text = '转课' AND status = '1' LIMIT 1)
	-- 原会员编号;新会员编号;原e_ptrest编号;新e_ptrest编号;转课节数;转课教练;转课店
	,${fld:custcode}||';'
		||(CASE WHEN ${fld:newcustcode} IS NOT NULL AND ${fld:newcustcode} != '' THEN ${fld:newcustcode} ELSE ${fld:custcode} END)||';'
		||${fld:ptrestcode}||';'||currval('seq_cc_ptrest')::varchar||';'||${fld:ptclasscount}::varchar||';'
		||(CASE WHEN ${fld:turnclasspt} IS NOT NULL THEN ${fld:turnclasspt} 
			ELSE (SELECT ptid FROM cc_ptrest WHERE code = ${fld:ptrestcode} and org_id = ${def:org}) END
		)||';'||${fld:org_id}
	,0
	,0
	,0
	,1
	,NULL
	,NULL
	,'${def:date}'
	,'${def:time}'
	,'${def:user}'
)
