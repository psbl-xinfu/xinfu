select 
	t.code
	,t.status
	,t.salemember
	,t.salemember1
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
	,t.remark
	,t.recommendcode
	,t.campaigncode
	,get_arr_value(t.relatedetail, 10) as daycount
	,get_arr_value(t.relatedetail, 11) as giveday
	,get_arr_value(t.relatedetail, 8) as ptcount
	,get_arr_value(t.relatedetail, 9) as starttype
	,get_arr_value(t.relatedetail, 5) as startdate
	,get_arr_value(t.relatedetail, 6) as enddate
	,get_arr_value(t.relatedetail, 3) as cardtype
	,(
		COALESCE((
			select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
			where (t2.relatecode = t.relatecode or t2.code = t.relatecode) and t2.stage_times_pay <= t.stage_times_pay 
			and t2.code != t.code and t2.org_id = t.org_id and t2.status != 0 
		),0.00)
	) as total_paymoney
	,t.stage_times_pay
	,t.stage_times_pay as current_stage_times_pay
	,(
		select max(t2.stage_times_pay) from cc_contract t2 
		where (t2.relatecode = t.code or t2.code = t.code) and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3 
	) as stage_times_pay
	,t.stagemoney
	,c2.name as recommendname
	,c2.mobile as recommendmobile
	,t.org_id
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
