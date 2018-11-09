insert into cc_report_monthly
(
	tuid,
	report_subject_id,
	report_year,
	report_month,
	amonut,
	category,
	org_id,
	created,
	createdby
)
values
(
	${seq:nextval@seq_cc_report_monthly},
	${fld:report_subject_id},
	${fld:date},
	${fld:report_month},
	${fld:amonut},
	${fld:category},
	${def:org},
    {ts'${def:timestamp}'},
    '${def:user}'
)


