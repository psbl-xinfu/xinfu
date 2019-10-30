update cc_guest set
	officeaddr=${fld:address} --公司地址
  	,email=${fld:cc_email} --公司邮箱
  	,officetel = ${fld:cc_officetel} --公司电话
  	,officename = ${fld:company} --公司名称
  	,province2 = ${fld:province2} --省
  	,city2 = ${fld:city2} --市
  	,customtype = ${fld:cc_birth} --客户类型
  	,postcode = ${fld:postalcode} --公司邮编
  	,remark = ${fld:cc_remark}
where
	code = ${fld:cc_code} and org_id='${def:org}'
	
	
	
	
	
	
