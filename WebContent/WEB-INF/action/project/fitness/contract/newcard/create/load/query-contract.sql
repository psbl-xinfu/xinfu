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
	,get_arr_value(t.relatedetail, 10) as daycount
	,get_arr_value(t.relatedetail, 11) as giveday
	,get_arr_value(t.relatedetail, 8) as ptcount
	,get_arr_value(t.relatedetail, 9) as starttype
	,get_arr_value(t.relatedetail, 5) as startdate
	,get_arr_value(t.relatedetail, 6) as enddate
	,get_arr_value(t.relatedetail, 3) as cardtype
	--查询出卡类型 0 时效卡 ；1 计次卡；2储值卡 zzn 
	,(select p.type from cc_cardtype p where p.code= get_arr_value(t.relatedetail, 3)and p.org_id=t.org_id)as type
	,COALESCE(t.stage_times,1) AS stage_times
	,t.stagemoney
	,c2.name as recommendname
	,c2.mobile as recommendmobile
	,t.org_id
	,t.stage_times_pay
	,(select ta.tuid from t_attachment_files ta where ta.pk_value = t.customercode
	and ta.table_code = 'cc_customer' and ta.org_id= ${def:org} order by ta.tuid desc limit 1) as custimgid
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
