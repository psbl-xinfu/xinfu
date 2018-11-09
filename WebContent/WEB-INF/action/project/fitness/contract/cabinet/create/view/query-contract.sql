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
	,get_arr_value(t.relatedetail,1) as cabinetid
	,b.cabinetcode
	,b.groupid
	,g.groupname
	,get_arr_value(t.relatedetail,2) as months
	,get_arr_value(t.relatedetail,10) as price
	,get_arr_value(t.relatedetail,3) as begindate
	,get_arr_value(t.relatedetail,4) as enddate
	,get_arr_value(t.relatedetail,5) as deposit
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,(t.inimoney-t.normalmoney) as discountmoney
	,COALESCE(t.factmoney,0.0) as factmoney
	,t.remark
	,t.recommendcode
	,(
		case when t.isaudit >= 1 then '特批折扣合同' 
			when t.campaigncode is not null and t.campaigncode != '' then '活动折扣合同' 
			when t.inimoney = t.normalmoney then '不打折' 
			else '正价合同' end 
	) as discounttype
	,t.pay_detail
	,t.org_id
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1 
left join cc_cabinet b on b.tuid = get_arr_value(t.relatedetail,1)::integer and t.org_id = b.org_id 
left join cc_cabinet_group g on g.tuid = b.groupid and g.org_id = b.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
