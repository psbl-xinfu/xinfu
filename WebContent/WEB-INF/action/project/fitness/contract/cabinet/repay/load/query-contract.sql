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
	,get_arr_value(t.relatedetail,8) as pt
	,get_arr_value(t.relatedetail,9) as ptname
	,t.source
	,t.relatedetail
	,t.inimoney
	,t.normalmoney
	,t.remark
	,t.recommendcode
	,t.relatecode
	,t.org_id
from cc_contract t 
where t.code = ${fld:contractcode} and t.org_id = ${def:org} 
