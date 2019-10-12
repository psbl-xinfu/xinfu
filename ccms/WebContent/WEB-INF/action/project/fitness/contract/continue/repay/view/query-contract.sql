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
	,t.normalmoney
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
	,(select name from cc_cardtype where code = get_arr_value(t.relatedetail, 2) and org_id = ${def:org}) as oldcardtypename
	,(
		select d.nowcount from cc_card d where d.code = get_arr_value(t.relatedetail, 1) and d.contractcode = get_arr_value(t.relatedetail, 20) limit 1
	) as oldnowcount
	,(
		select d.startdate from cc_card d where d.code = get_arr_value(t.relatedetail, 1) and d.contractcode = get_arr_value(t.relatedetail, 20) limit 1
	) as oldstartdate
	,get_arr_value(t.relatedetail, 14) as oldenddate
	,(select name from hr_staff where userlogin = get_arr_value(t.relatedetail, 21)) as oldmcname
	,(select name from hr_staff where userlogin = get_arr_value(t.relatedetail, 22)) as newmcname
	,t.remark
	,t.pay_detail
	,(
		select case when t2.isaudit >= 1 then '特批折扣合同' 
			when t2.campaigncode is not null and t2.campaigncode != '' then '活动折扣合同' 
			when t2.inimoney = t2.normalmoney then '不打折' 
			else '正价合同' end 
		from cc_contract t2 where t2.code = t.relatecode and t2.org_id = t.org_id
	) as discounttype
	,case when y.union_id is not null then (
		select string_agg(g.org_name,'&nbsp;&nbsp;&nbsp;') from t_union u 
		inner join t_union_club uc on u.tuid = uc.union_id 
		inner join hr_org g on g.org_id = uc.club_id 
		where u.tuid = y.union_id
	) else (
		select g.org_name from hr_org g where g.org_id = ${def:org}
	) end as supportorgs 
	,t.org_id
	,(select name from hr_staff st where st.userlogin = t.createdby) as createdby
	,(select name from hr_staff st where st.userlogin = t.collectby) as collectby
	,t.collectdate
	,t.collecttime
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join hr_staff f on f.userlogin = t.salemember 
left join hr_staff f1 on f1.userlogin = t.salemember1 
left join cc_cardtype ct on ct.code = get_arr_value(t.relatedetail, 3) and t.org_id = ct.org_id 
left join cc_cardcategory y on y.code = ct.cardcategory 
left join t_domain t1 on t1.domain_value = get_arr_value(t.relatedetail, 9) and t1.namespace = 'StartType' 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
