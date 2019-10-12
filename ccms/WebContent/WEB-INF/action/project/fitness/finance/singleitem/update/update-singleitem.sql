update cc_singleitem
set paytype = ${fld:i_paytype},
	status = 2,
	getmoney = ${fld:f_normalmoney},
	isguazhang = 0,
	pay_detail = ${fld:pay_detail},
	collectby = '${def:user}',
	collectdate = {ts'${def:timestamp}'},
	remark = ${fld:remark}
where code = ${fld:vc_code} and org_id = ${def:org}
