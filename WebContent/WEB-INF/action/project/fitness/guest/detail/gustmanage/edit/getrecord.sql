select
  	gt.code
  	,gt.officeaddr --公司地址
  	,gt.email --公司邮箱
  	,gt.officetel --公司电话
  	,gt.officename --公司名称
  	,gt.province2 --省
  	,gt.city2 --市
  	,gt.customtype --客户类型
  	,gt.postcode --公司邮编
  	,gt.remark 
  	,gt.mc
  	,tt.code as yttcode
from 
	cc_guest gt
left join cc_thecontact tt on tt.guestcode=gt.code and tt.status=1
where 
	gt.code = ${fld:code} and gt.org_id=${def:org}
