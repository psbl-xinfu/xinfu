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
	,(case when c.name is null then guest.name else c.name end) as custname
	,(case when c.mobile is null then guest.mobile else c.mobile end) as custmobile
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,COALESCE(t.factmoney,0.0) as factmoney

	,(
		select d.startdate from cc_card d where d.code = get_arr_value(t.relatedetail, 1) and d.contractcode = get_arr_value(t.relatedetail, 20) limit 1
	) as oldstartdate
	,get_arr_value(t.relatedetail, 5) as oldstartdate
	,get_arr_value(t.relatedetail, 6) as oldenddate
	,t.createdate as startdate
	,get_arr_value(t.relatedetail, 25) as enddate
	,get_arr_value(t.relatedetail, 3) as cardtype
	,get_arr_value(t.relatedetail, 1) as cardcode
	,(
		select d.nowcount from cc_card d where d.code = get_arr_value(t.relatedetail, 1) and d.contractcode = get_arr_value(t.relatedetail, 20) limit 1
	) as oldnowcount
	,(select name from hr_staff where userlogin = get_arr_value(t.relatedetail, 27)) as mcname
	,ct.name as cardtypename
	,t.remark
	,t.pay_detail
	,(
		case when t.isaudit >= 1 then '特批折扣合同' 
			when t.campaigncode is not null and t.campaigncode != '' then '活动折扣合同' 
			when t.inimoney = t.normalmoney then '不打折' 
			else '正价合同' end 
	) as discounttype
	,t.org_id
	
	,(select mm.name
 	from cc_contract cc
	left join cc_customer mm on mm.code= cc.customercode  and mm.org_id=${def:org}
 	where cc.code=get_arr_value(t.relatedetail,24)) as oldcustname
 	
 	, 	(select mm.mobile
 	from cc_contract cc
	left join cc_customer mm on mm.code= cc.customercode  and mm.org_id=${def:org}
 	where cc.code=get_arr_value(t.relatedetail,24)) as oldcustmobile
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join hr_staff f on f.userlogin = t.salemember
left join hr_staff f1 on f1.userlogin = t.salemember1
left join cc_guest guest on t.guestcode = guest.code and t.org_id = guest.org_id
left join cc_cardtype ct on ct.code = get_arr_value(t.relatedetail, 3) and t.org_id = ct.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
