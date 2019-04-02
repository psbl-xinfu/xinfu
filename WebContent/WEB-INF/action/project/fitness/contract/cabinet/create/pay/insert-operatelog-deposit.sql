/* 租柜押金 zzn 这个插入的记录是对的，只是押金*/
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
		||lpad(nextval('seq_cc_operatelog')::varchar, 8, '0')
	,(
		SELECT c1.param_value::integer FROM cc_config c1 
		WHERE category = 'OpeCategory' AND param_text = '租柜押金' and c1.org_id = (
			case when not exists(
				select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
			) then (
				select org_id from hr_org where (pid is null or pid = 0)
			) else ${def:org} end
		) limit 1
	)
	,t.customercode
	,COALESCE(get_arr_value(t.relatedetail,5),'0')::double precision
	,COALESCE(get_arr_value(t.relatedetail,5),'0')::double precision
	,COALESCE(get_arr_value(t.relatedetail,5),'0')::double precision
	,1
	,'0;0;0;0'	-- paydetail
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
