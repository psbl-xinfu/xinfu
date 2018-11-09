select 
	t.code
	,t.status
	,t.salemember
	,f.name as salemembername
	,t.salemember1
	,f1.name as salemembername1
	,t.discounttype
	,t.isaudit
	,t.createdby
	,t.createdate
	,t.createtime
	,t.customercode
	,c.name as custname
	,c.mobile as custmobile
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,(t.inimoney - t.normalmoney) as discountmoney
	,COALESCE(t.factmoney,0.0) as factmoney
	,(select sum(factmoney) from cc_contract where relatecode = t.code and org_id = ${def:org} and status = 2) as relatecodefactmoney
	,t.campaigncode
	,get_arr_value(t.relatedetail, 10) as daycount
	,get_arr_value(t.relatedetail, 11) as giveday
	,get_arr_value(t.relatedetail, 8) as ptcount
	,get_arr_value(t.relatedetail, 9) as starttype
	,t1.domain_text_cn as starttypename
	,get_arr_value(t.relatedetail, 5) as startdate
	,get_arr_value(t.relatedetail, 6) as enddate
	,get_arr_value(t.relatedetail, 3) as cardtype
	,get_arr_value(t.relatedetail, 1) as cardcode
	,ct.name as cardtypename
	,COALESCE(t.stage_times,1) AS stage_times
	,t.stagemoney
	,(
		case when t.stage_times >= 2 then COALESCE(t.factmoney,0.00)+COALESCE((
			select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
			where t2.relatecode = t.code and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3
		),0.00) else t.factmoney end
	) as total_paymoney
	,(
		select max(t2.stage_times_pay) from cc_contract t2 
		where (t2.relatecode = t.code or t2.code = t.code) and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3 
	) as stage_times_pay
	,(
		select max(t2.stage_times_pay)+1 from cc_contract t2 
		where (t2.relatecode = t.code or t2.code = t.code) and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3 
	) as current_stage_times_pay
	,t.remark
	,t.campaigncode
	,n.campaign_name
	,t.recommendcode
	,c2.name as recommendname
	,c2.mobile as recommendmobile
	,t.pay_detail
	,(
		case when t.isaudit >= 1 then '特批折扣合同' 
			when t.campaigncode is not null and t.campaigncode != '' then '活动折扣合同' 
			when t.inimoney = t.normalmoney then '不打折' 
			else '正价合同' end 
	) as discounttype
	,(select memberhead from hr_org where org_id = ${def:org}) as cardhead
	,t.org_id
	,( 
	CASE WHEN (t.stage_times - t.stage_times_pay) = 0 THEN 0 
	ELSE (case when (t.stage_times - t.stage_times_pay-( 
	SELECT count(1) FROM cc_contract t1 
	WHERE t1.relatecode =  t.code  AND t1.status >= 2 and t1.org_id = t.org_id 
	))=0 then 0 else ( 
	t.normalmoney - t.factmoney - ( 
	COALESCE (( 
	SELECT SUM (t1.factmoney) FROM cc_contract t1 
	WHERE t1.relatecode =  t.code  AND t1.status >= 2 and t1.org_id = t.org_id 
	),0.00) 
	) 
	) / (t.stage_times - t.stage_times_pay-( 
	SELECT count(1) FROM cc_contract t1 
	WHERE t1.relatecode =  t.code  AND t1.status >= 2 and t1.org_id = t.org_id 
	))end)
	END 
)::numeric(10,2) as fqmoney 
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1 
left join cc_cardtype ct on ct.code = get_arr_value(t.relatedetail, 3) and t.org_id = ct.org_id 
left join t_domain t1 on t1.domain_value = get_arr_value(t.relatedetail, 9) and t1.namespace = 'StartType' 
left join cc_campaign n on n.code = t.campaigncode and n.org_id = t.org_id 
where t.code = ${fld:relatecode} and t.org_id = ${def:org} 
