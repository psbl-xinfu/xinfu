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
	,get_arr_value(t.relatedetail,1) as cabinetid
	,b.cabinetcode
	,b.groupid
	,get_arr_value(t.relatedetail,2) as months
	,get_arr_value(t.relatedetail,10) as price
	,get_arr_value(t.relatedetail,3) as begindate
	,get_arr_value(t.relatedetail,4) as enddate
	,t.remark
	,t.recommendcode
	,t.org_id
from cc_contract t 
left join cc_customer c on c.code = t.customercode and t.org_id = c.org_id 
left join cc_cabinet b on b.tuid = get_arr_value(t.relatedetail,1)::integer and t.org_id = b.org_id 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
