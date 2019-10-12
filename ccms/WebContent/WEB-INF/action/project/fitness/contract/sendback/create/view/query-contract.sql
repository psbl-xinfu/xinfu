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
	,get_arr_value(t.relatedetail,1) as cardcode
	,get_arr_value(t.relatedetail,2) as cardcontractcode
	,get_arr_value(t.relatedetail,3) as usedays
	,get_arr_value(t.relatedetail,4) as oldinimoney
	,get_arr_value(t.relatedetail,5) as oldnormalmoney
	,get_arr_value(t.relatedetail,6) as oldleftmoney
	,get_arr_value(t.relatedetail,7) as oldmoneyleft
	,d.startdate
	,d.enddate
	,d.count
	,d.nowcount
	,e.name as cardtypename
	,t.normalmoney
	,COALESCE(t.factmoney,0.0) as factmoney
	,t.remark
	,t.pay_detail
	,t.org_id
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,t.createdate
	,t.createtime
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1  
left join cc_card d on d.code = get_arr_value(t.relatedetail,1) and d.contractcode = get_arr_value(t.relatedetail,2) and d.org_id = t.org_id 
left join cc_cardtype e on e.code = d.cardtype and e.org_id = d.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
