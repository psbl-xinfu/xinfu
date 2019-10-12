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
	,(t.inimoney-t.normalmoney) as discountmoney
	,t.remark
	,t.recommendcode
	,t.campaigncode
	,get_arr_value(t.relatedetail, 1) as cardcode
	,get_arr_value(t.relatedetail, 10) as daycount
	,get_arr_value(t.relatedetail, 11) as giveday
	,get_arr_value(t.relatedetail, 8) as ptcount
	,get_arr_value(t.relatedetail, 9) as starttype
	,(
		select n.domain_text_cn from t_domain n where n.namespace = 'StartType' and n.domain_value = get_arr_value(t.relatedetail, 9) limit 1
	) as starttypename
	,get_arr_value(t.relatedetail, 5) as startdate
	,get_arr_value(t.relatedetail, 6) as enddate
	,get_arr_value(t.relatedetail, 3) as cardtype
	,get_arr_value(t.relatedetail, 21) as oldmc
	,get_arr_value(t.relatedetail, 22) as newmc
	,get_arr_value(t.relatedetail, 9) as starttype
	,t.stage_times
	,t.stagemoney
	,t.org_id
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
