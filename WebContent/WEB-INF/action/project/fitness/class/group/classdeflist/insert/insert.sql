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
	nowcount,
	org_id
)
values
(
	${seq:nextval@seq_cc_classlist},
	${fld:week},
	${fld:classcode},
	${fld:classroomcode},
	${fld:teacherid},
	${fld:limitcount},
	${fld:price},
	${fld:classdate},
	${fld:classtime},
	${fld:status},
	${fld:remark},
	0,
	${def:org}
)









