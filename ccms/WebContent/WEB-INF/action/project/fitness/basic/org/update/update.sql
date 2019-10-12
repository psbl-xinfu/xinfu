update hr_org 
set
	org_name = ${fld:org_name}
	,remark = ${fld:remark}
	,show_order = ${fld:show_order}
	,short_name = ${fld:short_name}
	,org_type = ${fld:org_type}
	,org_code = ${fld:org_code}
	,memberhead = ${fld:memberhead} 
where org_id = ${fld:tuid}