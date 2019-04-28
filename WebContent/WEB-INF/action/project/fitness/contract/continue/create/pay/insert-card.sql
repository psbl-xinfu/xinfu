INSERT INTO cc_card(
	code
	,isgoon
	,customercode
	,cardtype
	,startdate
	,enddate
	,totalday
	,giveday
	,factmoney
	,count
	,nowcount
	,status
	,created
	,createdby
	,remark
	,starttype
	,contractcode
	,stopdays
	,org_id
) 
SELECT 
	get_arr_value(t.relatedetail, 1)
	,1
	,t.customercode
	,get_arr_value(t.relatedetail, 3)	-- cardtype
	--续卡虽然写入了卡时间但实际应用时后续卡的开始和截止时间都是依照上一张卡的时间结束时间计算的 zzn注释
	,(CASE get_arr_value(t.relatedetail, 5) WHEN '' THEN NULL ELSE get_arr_value(t.relatedetail, 5) END)::date	-- startdate
	,(CASE get_arr_value(t.relatedetail, 6) WHEN '' THEN NULL ELSE get_arr_value(t.relatedetail, 6) END)::date	-- enddate
	,get_arr_value(t.relatedetail, 10)::integer	-- totalday
	,get_arr_value(t.relatedetail, 11)::integer	-- giveday
	,t.normalmoney	-- factmoney
	,(SELECT d.count FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id)
	,(SELECT d.count FROM cc_cardtype d WHERE d.code = get_arr_value(t.relatedetail, 3) AND d.org_id = t.org_id)
	,2 --zzn 未启用
	,{ts '${def:timestamp}'}
	,'${def:user}'
	,t.remark
	,get_arr_value(t.relatedetail, 9)::integer	-- starttype
	,t.code 
	,0 
	,t.org_id 
FROM cc_contract t
WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} 
