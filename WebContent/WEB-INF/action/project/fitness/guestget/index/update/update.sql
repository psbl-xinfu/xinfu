update cc_guest
set name = ${fld:name},
	mobile = ${fld:mobile},
	sex = ${fld:sex},
	age = ${fld:age},
	intention = ${fld:intention},
	isaddwx = ${fld:isaddwx},
	communication = ${fld:communication},
	remark = ${fld:remark},
	demand = ${fld:demand}
where code = ${fld:tuid} and org_id = ${def:org}