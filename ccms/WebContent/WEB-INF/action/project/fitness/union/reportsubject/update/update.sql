update cc_report_subject set 
	category= ${fld:formcategory},
	subjectname= ${fld:subjectname},
	showorder= ${fld:showorder},
	remark= ${fld:remark},
	updated={ts '${def:timestamp}'},
	updatedby='${def:user}'
where tuid = ${fld:tuid} and org_id = ${def:org}


