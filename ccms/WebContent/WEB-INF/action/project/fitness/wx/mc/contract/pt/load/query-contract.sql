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
	,get_arr_value(t.relatedetail,8) as pt
	,get_arr_value(t.relatedetail,9) as ptname
	,p.code as ptlevelcode
	,p.ptlevelname
	,get_arr_value(t.relatedetail,2) as ptcount
	,get_arr_value(t.relatedetail,3) as ptenddate
	,get_arr_value(t.relatedetail,4) as ptfee
	,t.source
	,(
		select d1.domain_text_cn from t_domain d1 
		where d1.domain_value = t.source and d1.namespace = 'Source' limit 1
	) as sourcename
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,t.remark
	,t.recommendcode
	,c2.name as recommendname
	,c2.mobile as recommendmobile
	,t.org_id
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_customer c2 on c2.code = t.recommendcode and t.org_id = c2.org_id 
left join cc_ptdef p on p.code = get_arr_value(t.relatedetail,1) and t.org_Id = p.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
