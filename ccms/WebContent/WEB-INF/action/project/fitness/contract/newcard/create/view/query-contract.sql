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
	,ct.type as cardtypetype
	,COALESCE(t.stage_times,1) AS stage_times
	,t.stagemoney
	,(
		select max(t2.stage_times_pay)+1 from cc_contract t2 
		where (t2.relatecode = t.code or t2.code = t.code) and t2.org_id = t.org_id and t2.status != 0 and t2.isaudit != 3 
	) as stage_times_pay
	,t.remark
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
	,t.createdate
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,t.createtime
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
	,(select ta.tuid from t_attachment_files ta where ta.pk_value = t.customercode
	and ta.table_code = 'cc_customer' and ta.org_id= ${def:org} order by ta.tuid desc limit 1) as custimgid
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1 
left join cc_cardtype ct on ct.code = get_arr_value(t.relatedetail, 3) and t.org_id = ct.org_id 
left join t_domain t1 on t1.domain_value = get_arr_value(t.relatedetail, 9) and t1.namespace = 'StartType' 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
