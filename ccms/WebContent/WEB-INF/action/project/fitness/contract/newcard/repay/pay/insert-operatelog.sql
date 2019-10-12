INSERT INTO cc_operatelog(
	code
	,opertype
	,relatedetail
	,inimoney
	,normalmoney
	,factmoney
	,status
	,pay_detail
	,remark
	,createdby
	,createdate
	,createtime
	,updatedby
	,updatedate
	,updatetime
	,pk_value
	,customercode
	,org_id
) 
SELECT
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')
		||lpad(currval('seq_cc_operatelog')::varchar, 8, '0')
	,(
		SELECT c1.param_value FROM cc_config c1 
		WHERE category = 'OpeCategory' AND param_text = '办卡' and c1.org_id = (
			case when not exists(
				select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
			) then (
				select org_id from hr_org where (pid is null or pid = 0)
			) else ${def:org} end
		) limit 1
	)
	,concat(t.customercode,';',COALESCE(get_arr_value(t.relatedetail, 1),''))
	,t.inimoney
	,t.normalmoney
	,${fld:factmoney}
	,1
	,${fld:paydetail}
	,NULL
	,'${def:user}'
	,'${def:date}'
	,'${def:time}'
	,NULL
	,NULL
	,NULL
	,t.code
	,t.customercode
	,t.org_id
FROM cc_contract t 
WHERE t.code = ${fld:contractcode} and t.org_id = ${def:org}
