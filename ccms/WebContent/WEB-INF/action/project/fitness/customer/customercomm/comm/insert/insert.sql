insert into cc_comm
(
    code,
    cust_type,
    customercode,
    guestcode,
    commtarget,
    commresult,
    nexttime,
    failreason,
    remark,
    preparecode,
    callstatus,
    status,
    createdby,
    created,
    org_id,
    pk_value,
    operatortype
)
values 
(
	${seq:nextval@seq_cc_comm},
    ${fld:cust_type},
    ${fld:customercode},
    ${fld:guestcode},
    ${fld:commtarget},
    ${fld:commresult},
    ${fld:nexttime},
    ${fld:failreason},
    ${fld:remark},
    (case 
    	when ${fld:commresult}='2' and ${fld:cust_type}='0' then ${seq:currval@seq_cc_guest_prepare} 
    	when ${fld:commresult}='2' and ${fld:cust_type}='1' then ${seq:currval@seq_cc_prepare}
    end),
    ${fld:callstatus},
    1,
    ${fld:createdby},
    {ts'${def:timestamp}'},
    ${def:org},
    (select code from cc_mcchange where 
    (guestcode = ${fld:guestcode} or customercode = ${fld:customercode}) 
    and org_id = ${def:org} order by created desc limit 1),
    2
)
