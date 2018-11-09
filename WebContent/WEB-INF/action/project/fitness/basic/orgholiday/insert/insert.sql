insert into hr_org_holiday
(
    tuid,
    org_id,
    begintime,
    endtime,
    remark,
    status,
    createdby,
    created
)
values 
(
	${seq:nextval@seq_hr_org_holiday},
	${def:org},
    ${fld:begintime},
    ${fld:endtime},
    ${fld:remark},
    2,
    '${def:user}',
    {ts'${def:timestamp}'}
)
