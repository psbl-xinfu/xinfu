update  cc_device set
	deviceid = ${fld:dev_deviceid},
	appid = ${fld:dev_appid},
	status = ${fld:dev_status},
	remark = ${fld:dev_remark},
	updated ='${def:user}',
	updatedby = {ts'${def:timestamp}'}
where code=${fld:cnfg_id}
