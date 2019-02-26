insert into cc_classlist
(
	code,
	weekday,
	classcode,
	classroomcode,
	teacherid,
	limitcount,
	price,
	classdate,
	classtime,
	status,
	remark,
	org_id,
	isprepare
)
(
	select 
		${seq:nextval@seq_cc_classlist},
		weekday,
		classcode,
		classroomcode,
		teacherid,
		limitcount,
		price,
		${fld:classdate},
		classtime,
		2,
		remark,
		${def:org},
		isprepare
	from cc_classlist 
	where code = ${fld:code} and org_id = ${def:org}
)
