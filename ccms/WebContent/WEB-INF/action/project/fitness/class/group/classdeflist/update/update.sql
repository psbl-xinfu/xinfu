update cc_classlist
set
	weekday=${fld:week},
	classcode=${fld:classcode},
	classroomcode=${fld:classroomcode},
	teacherid=${fld:teacherid},
	limitcount=${fld:limitcount},
	price=${fld:price},
	classdate=${fld:classdate},
	classtime=${fld:classtime},
	status=${fld:status},
	remark=${fld:remark}
where code = ${fld:vc_code} and org_id= ${def:org}








