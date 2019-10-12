insert into cc_comm
(
    code,
    cust_type,
    customercode,
    commtarget,
    commresult,
    nexttime,
    reason,
    remark,
    preparecode,
    stage,
    callstatus,
    level,
    status,
    createdby,
    created,
    org_id,
    pk_value,
    operatortype,
    commway
)
values 
(
	${seq:nextval@seq_cc_comm},
    ${fld:cust_type},
    ${fld:customercode},
    ${fld:commtarget},
    ${fld:commresult},
    ${fld:nexttime},
    ${fld:reason},
    ${fld:remark},
     (case when ${fld:commresult}='2' then  ${seq:nextval@seq_cc_prepare} else null end),
    -- ${fld:preparecode},
    ${fld:stage},
    ${fld:callstatus},
    ${fld:level},
    1,
    ${fld:createdby},
    {ts'${def:timestamp}'},
    ${def:org},
    (select code from cc_mcchange where customercode = ${fld:customercode} and org_id = ${def:org} order by created desc limit 1),
    0,
    ${fld:commway}
)
