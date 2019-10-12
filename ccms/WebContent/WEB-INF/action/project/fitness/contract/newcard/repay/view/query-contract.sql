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
	,t.normalmoney AS current_normalmoney
	,(select t2.inimoney from cc_contract t2 where t2.code = t.relatecode and t2.org_id = t.org_id) as inimoney
	,(select t2.normalmoney from cc_contract t2 where t2.code = t.relatecode and t2.org_id = t.org_id) as normalmoney
	,(select t2.inimoney - t2.normalmoney from cc_contract t2 where t2.code = t.relatecode and t2.org_id = t.org_id) as discountmoney
	,COALESCE(t.factmoney,0.0) as factmoney
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
		select max(t2.stage_times_pay) from cc_contract t2 
		where (t2.relatecode = t.code or t2.code = t.code) and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3 
	) as stage_times_pay
	,t.remark
	,t.recommendcode
	,c2.name as recommendname
	,c2.mobile as recommendmobile
	,t.pay_detail
	,(
		select case when t2.isaudit >= 1 then '特批折扣合同' 
			when t2.campaigncode is not null and t2.campaigncode != '' then '活动折扣合同' 
			when t2.inimoney = t2.normalmoney then '不打折' 
			else '正价合同' end 
		from cc_contract t2 where t2.code = t.relatecode and t2.org_id = t.org_id
	) as discounttype
	,(select memberhead from hr_org where org_id = ${def:org}) as cardhead
	,t.org_id
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,t.createdate
	,t.createtime
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1
left join cc_cardtype ct on ct.code = get_arr_value(t.relatedetail, 3) and t.org_id = ct.org_id 
left join t_domain t1 on t1.domain_value = get_arr_value(t.relatedetail, 9) and t1.namespace = 'StartType' 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
