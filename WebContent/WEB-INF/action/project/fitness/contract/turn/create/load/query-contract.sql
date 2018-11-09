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
	,get_arr_value(t.relatedetail, 20) as oldcustomercode
	,c.name as custname
	,c.mobile as custmobile
	,(case when c2.name is null then guest.code else c2.code end) as newcustcode
	,(case when c2.name is null then guest.name else c2.name end) as newcustname
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,t.remark
	,t.campaigncode
	,get_arr_value(t.relatedetail, 1) as cardcode
	,(
		select n.domain_text_cn from t_domain n where n.namespace = 'StartType' and n.domain_value = get_arr_value(t.relatedetail, 9) limit 1
	) as starttypename
	,t.createdate as startdate
	,get_arr_value(t.relatedetail, 25) as enddate
	,(select f.name from hr_staff f where f.userlogin = get_arr_value(t.relatedetail, 27) limit 1) as mcname
	,t.org_id
from cc_contract t 
left join cc_customer c on c.code = get_arr_value(t.relatedetail, 20) and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.customercode and t.org_id = c2.org_id 
left join cc_guest guest on t.guestcode = guest.code and t.org_id = guest.org_id
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
