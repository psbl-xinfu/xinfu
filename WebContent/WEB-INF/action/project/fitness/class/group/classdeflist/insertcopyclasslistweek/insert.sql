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
		to_char((classdate::date+ (${fld:week}||' day')::interval),'yyyy-MM-dd')::date,
		classtime,
		2,
		remark,
		${def:org},
		isprepare
	from cc_classlist 
	where (classdate>=${fld:startdate} and classdate<=${fld:enddate})
	and org_id = ${def:org}
)
