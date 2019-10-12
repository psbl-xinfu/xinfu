insert into cc_report_subject
(
    tuid,
    category,
    subjectname,
    grade,
    showorder,
    status,
    pid,
    remark,
    created,
    createdby,
    org_id
)
values 
(
	${seq:nextval@seq_cc_report_subject},
    ${fld:formcategory},
    ${fld:subjectname},
    (case when ${fld:pid} is null then 1 else 
    	1+(select grade from cc_report_subject where tuid = ${fld:pid} and org_id = ${def:org}) end),
    ${fld:showorder},
    1,
    ${fld:pid},
    ${fld:remark},
	{ts '${def:timestamp}'},
	'${def:user}',
    ${def:org}
)
